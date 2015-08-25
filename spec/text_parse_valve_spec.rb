# text_parse_valve_spec.rb - specs for text_parse_valve

require_relative 'spec_helper'

describe 'text_parse_valve' do
  let(:gen) { MdGen.new }
  let(:lgen) { ->(x){ gen.eval_string(x)} }
  let(:chain) { lgen | ->(x){ text_parse_valve(x) }; lgen }

  describe 'h1 "header"' do
    subject { chain.call_chain"h1 'header'" }

    specify { subject.must_equal [[:h1, [[:t, 'header']] ]] }
  end

  describe 'numbers' do
    subject { chain.call_chain "numbers 'Item 1', '[bold Item 2]'" }

    specify { subject.must_equal [
      [:ol, [
        [[:t, 'Item 1']],
        [[:bold, 'Item 2']]
]
  ] ] }
  end

  describe 'bullets' do
    subject { chain.call_chain "bullets 'Item 1', '[bold Item 2]'" }

    specify { subject.must_equal [
      [:ul, [
        [[:t, 'Item 1']],
        [[:bold, 'Item 2']]
]
  ] ] }
  end

  describe 'link' do
    subject { chain.call_chain "link \"This is [ital Example's] Homepage\", 'http://www.example.com'" }

    specify { subject.must_equal [
      [:a, [
    [[:t, 'This is '],
        [:ital, "Example's"],
        [:t, ' Homepage']
],
      'http://www.example.com']
      ]
    ] }
  end

  describe 'para' do
    subject { chain.call_chain "para 'Some [ital italic] text'" }

    specify { subject.must_equal [[:para, [[:t, 'Some '], [:ital, 'italic'], [:t, ' text']] ]] }
  end
end
