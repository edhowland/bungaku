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
end
