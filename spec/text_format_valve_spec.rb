# text_format_valve_spec.rb - specs for text_format_valve

require_relative 'spec_helper'

describe 'text_format_valve' do
  describe 'empty' do
    specify { text_format_valve([]).must_equal [] }
  end

  describe 'is_heading?' do
  [:h1, :h2, :h3, :h4, :h5, :h6].each {|h|
      code = [h, []]
      specify { is_heading?(code).must_equal true }
    }

    [:para, :ul, :ol, :code, :a].each {|c|
      code = [c]
      specify { is_heading?(code).must_equal false }
    }
  end


  describe 'is_para?' do
    specify { is_para?([:para]).must_equal true }

    [:ul, :ol, :code, :a, :h1, :h2, :h3, :h4, :h5, :h6].each {|c|
      code = [c]
      specify { is_para?(code).must_equal false }
    }
  end
  describe 'h1 "bold [bold heading]"' do
    let(:codes) { [[:h1, 'this is [bold heading]']] }
    let(:lparse) { ->(x){ text_parse_valve(x) } }
    let(:chain) { lparse | ->(x){ text_format_valve(x) }; lparse }
    subject { chain.call_chain codes }

    specify { subject.must_equal [[:h1, 'this is **heading**']] }
  end

  describe 'link' do
    let(:codes) { [[:a, ['go to [ital example.com]', 'http://example.com']] ] }
    let(:lparse) { ->(x){ text_parse_valve(x) } }
    let(:chain) { lparse | ->(x){ text_format_valve(x) }; lparse }
    subject { chain.call_chain codes }

  specify { subject.must_equal [[:a, ['go to *example.com*', 'http://example.com']]] }
  end

  describe 'is_list?' do
    specify { is_list?([:ul]).must_equal true }
    specify { is_list?([:ol]).must_equal true }
    [:para, :a, :code, :h1, :h2, :h3, :h4, :h5, :h6].each {|c|
      code = [c]
      specify { is_list?(code).must_equal false }
    }
  end
  describe 'bullets' do
  let(:lgen) { ->(x){ MdGen.new.eval_string(x)} }
    let(:chain) { lgen | ->(x){ text_parse_valve(x)} | ->(x){ text_format_valve(x) }; lgen }
    subject { chain.call_chain "bullets 'note 1', '[ital note 2]', '[bold note 3]'"}

    specify { subject.must_equal [[:ul, ['note 1', '*note 2*', '**note 3**']] ] }
  end
  describe 'numbers' do
  let(:lgen) { ->(x){ MdGen.new.eval_string(x)} }
    let(:chain) { lgen | ->(x){ text_parse_valve(x)} | ->(x){ text_format_valve(x) }; lgen }
    subject { chain.call_chain "numbers 'note 1', '[ital note 2]', '[bold note 3]'"}

    specify { subject.must_equal [[:ol, ['note 1', '*note 2*', '**note 3**']] ] }
  end

  describe 'is_para?' do
    specify { is_para?([:para]).must_equal true }

  [:h1, :h2, :h3, :h4, :h5, :h6, :a, :ul, :ol, :page].each {|c|
      code = [c]
      specify { is_para?(code).must_equal false }
    }
  end

  describe 'para' do
  let(:lgen) { ->(x){ MdGen.new.eval_string(x)} }
    let(:chain) { lgen | ->(x){ text_parse_valve(x)} | ->(x){ text_format_valve(x) }; lgen }
    subject { chain.call_chain "para '[bold bold][ital italic] plain'" }

    specify { subject.must_equal [[:para, '**bold***italic* plain']] }
  end
end
