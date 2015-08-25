# pager_spec.rb - specs for Pager

require_relative 'spec_helper'



describe Pager do
  let(:pager) { Pager.new }

  describe 'count_pages' do
    let(:codes0) { []}
    let(:codes2) { [[:page, nil], [:page, nil]] }
    let(:counter0) { pager.count_pages codes0 }
    subject { pager.count_pages codes2 }

     specify { counter0.must_equal 0 }
    specify { subject.must_equal 2 }
  end

  describe 'complex count_pages' do
    let(:codes0) {[[:para, ''], [:code, ''], [:a, '', '']] }
    let(:codes) { [[:para, ''], [:page, nil], [:code, ''], [:page, nil]] }
    let(:counter0) { pager.count_pages codes0 }
    subject { pager.count_pages codes }

    specify { counter0.must_equal 0 }
    specify { subject.must_equal 2 }
  end

  describe 'ennumber_pages []' do
    subject { pager.ennumber_pages [] }

    specify { subject.must_equal [] }
  end

  describe 'ennumber_pages with no pages' do
    let(:codes) { [[:para, ''], [:code, '']] }
    subject { pager.ennumber_pages codes }

    specify { subject.must_equal codes }
  end

  describe 'ennumber_pages' do
    let(:codes) { [[:page, nil], [:page, nil]] }
    subject { pager.ennumber_pages codes, 2 }

    specify { subject.must_equal [[:page, 1,2, nil], [:page, 2,2, nil]] }
  end


  describe 'count_and_ennumber_pages' do
    let(:codes) { [[:page, nil], [:page, nil], [:page, nil]] }
    subject { pager.count_and_ennumber_pages codes }

  specify { subject.must_equal [[:page, 1, 3, nil], [:page, 2, 3, nil], [:page, 3, 3, nil]] }
  end

  describe 'count_and_ennumber_pages []' do
    subject { pager.count_and_ennumber_pages [] }
    specify { subject.must_equal [] }
  end

  describe 'count_and_ennumber_pages with no pages' do
    let(:codes) { [[:a, '', ''], [:ul, []], [:ol, ['', '']], [:para, '']] }
    subject { pager.count_and_ennumber_pages codes }

    specify { subject.must_equal codes }
  end
end

describe 'Pager call Procs' do
  let(:gen) { MdGen.new }
  let(:pager) { Pager.new }

  describe 'call_lambdai with one page and inner h1' do
    let(:codes) { gen.eval_string 'page {|p, t| h1 "#{p}, #{t}" }' }
    let(:counter) { pager.count_and_ennumber_pages codes }
    subject { pager.call_lambda counter }

    specify { subject.must_equal [[:page, 1, 1, [[:h1, '1, 1']] ]] }
end

  describe 'called with no pages' do
    #let(:codes) { gen.eval_string "para 'hello'; codes ''" }
    let(:codes) { gen.eval_string 'para "hello"; code ""' }
    let(:counter) { pager.count_and_ennumber_pages codes }
    subject { pager.call_lambda counter }

    specify { subject.must_equal [[:para, 'hello'], [:code, '']] }
  end
end

describe 'split page content and page' do
  let(:pager) { Pager.new }

  describe 'split_code' do
    let(:code) {  [:page, 1, 2, [[:para, 'text']] ] }
    before { @content, @page = pager.split_code code }

    specify { @content.must_equal [[:para, 'text']] }
    specify { @page.must_equal [:page, 1, 2] }
  end

  describe 'single element' do
    let(:codes) { [[:page, 1, 1, [[:para, 'text']] ]] }
    subject { pager.split_content_and_page codes }

  specify {  subject.must_equal [[:para, 'text'], [:page, 1, 1]] }
  end
end

describe 'Integrated content' do
  let(:gen) { MdGen.new }
  let(:pager) { Pager.new }
  let(:lgen) { ->(x){ gen.eval_string(x) } }
  let(:chain) { lgen | ->(x){ pager.process(x) }; lgen }
  before do
    @content = <<-EOD
      page {|page_no, total|
        h6 "Page \#{page_no} of \#{total}"
      }
      page {|page_no, total|
        h6 "Page \#{page_no} of \#{total}"
      } 
EOD
  end

  subject { chain.call_chain @content }

  specify { subject.must_equal [
    [:h6, 'Page 1 of 2'],
    [:page, 1, 2],
    [:h6, 'Page 2 of 2'],
    [:page, 2, 2]
  ] }
end


describe 'Integrated content eith no pages' do
  let(:gen) { MdGen.new }
  let(:pager) { Pager.new }
  let(:lgen) { ->(x){ gen.eval_string(x) } }
  let(:chain) { lgen | ->(x){ pager.process(x) }; lgen }
  before do
    @content = <<-EOD
    page_no = 0; total = 0
        h6 "Page \#{page_no} of \#{total}"
        h6 "Page \#{page_no} of \#{total}"
EOD
  end

  subject { chain.call_chain @content }

  specify { subject.must_equal [
    [:h6, 'Page 0 of 0'],
    [:h6, 'Page 0 of 0']
  ] }
end
