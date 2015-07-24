# md_gen_spec.rb -  spec for MdGen

require '../lib/mdgen'
require 'minitest/autorun'


describe MdGen do
  before { @m = MdGen.new }

  describe 'simple paragraph element' do
    before do
      @m.process { para 'this is regular text' }
    end

    subject { @m.codes }

    specify { subject.must_equal [[:para, [[:t, 'this is regular text']]]]}
  end

  describe "paragraph with bold element" do
    before { @m.process { para 'This is [bold bold] text' }}

    subject { @m.codes }

    specify { subject.must_equal [[:para, [
        [:t, 'This is '], 
        [:bold, 'bold'], 
        [:t, ' text']
        ]]] }

  end
end

describe 'MdGen: complicated examples' do
  let(:gen) { MdGen.new }
  describe '3 types: h1, para, code' do
    subject { gen.process { h1 'head'; para 'text'; code 'code' }  }

  specify { subject.must_equal [[:h1, 'head'], [:para, [[:t, 'text']]], [:code, 'code']] }
  end

 describe 'code then para' do
    subject { gen.process { code 'code'; para 'text' } }

    specify { subject.must_equal [[:code, 'code'], [:para, [[:t, 'text']]]] }
  end

  describe 'render table' do
    subject { gen.process { table [
      ['head','head'],
        ['cell 1', 'cell 2'],
        ['row r21', 'col 2']
      ] } } 

    specify { subject.must_equal [[:table, [
      ['head','head'],
        ['cell 1', 'cell 2'],
        ['row r21', 'col 2']
      ]]] }
  end

  describe 'html_table' do
    subject { gen.process {  html_table [] } }

    specify { subject.must_equal [[:html_table, [], {}]] }
  end

  describe 'html_table with attributes' do
    subject { gen.process { html_table [], width: '10%' } }

    specify { subject.must_equal [[:html_table, [], {:width => '10%'}]] }
  end

  describe 'link' do
    subject { gen.process { link('A Link', 'http://example.com') } }

    specify { subject.must_equal  [[:a, ['A Link', 'http://example.com']]] }
  end

  describe 'importing .mdsl file' do
    subject { gen.process { import 'header.mdsl' } }

  # specify { subject.must_equal [[:h6, 'Report']] }
  end

  describe 'eval_string' do
    subject { gen.eval_string "h1 'head'" }

    specify { subject.must_equal [[:h1, 'head']] }
  end

  describe 'eval_string link' do
    subject { gen.eval_string "link 'A link', 'http://example.com'" }

    specify { subject.must_equal  [[:a, ['A link', 'http://example.com']]] }
  end
end
