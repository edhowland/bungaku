# text_parse_valve_spec.rb - specs for text_parse_valve

require_relative 'spec_helper'

describe 'text_parse_valve' do
  let(:gen) { MdGen.new }
  let(:pipe) { RenderPipeline.new }
  let(:runner) do
    pipe << ->(x) { gen.eval_string x }
    pipe << ->(x) { text_parse_valve x }
    pipe
  end

  describe 'h1 "header"' do
    subject { runner.run "h1 'header'" }

    specify { subject.must_equal [[:h1, [[:t, 'header']] ]] }
  end

  describe 'numbers' do
    subject { runner.run "numbers 'Item 1', '[bold Item 2]'" }

    specify { subject.must_equal [
      [:ol, [
        [[:t, 'Item 1']],
        [[:bold, 'Item 2']]
]
  ] ] }
  end

  describe 'bullets' do
    subject { runner.run "bullets 'Item 1', '[bold Item 2]'" }

    specify { subject.must_equal [
      [:ul, [
        [[:t, 'Item 1']],
        [[:bold, 'Item 2']]
]
  ] ] }
  end
end
