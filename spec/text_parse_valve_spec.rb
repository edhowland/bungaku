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

    specify { subject.must_equal [[:h1, 'header']] }
  end
end
