# integrate_gen_count_parse_spec.rb - specs for integrate_gen_count_parse

require_relative 'spec_helper'

describe 'MdGen -> PageCounter -> TextParse' do
  let(:gen) { MdGen.new }
  let(:counter) { PageCounter.new }
    let(:inter) { InterpolateVariables.new }
  let(:pipe) { RenderPipeline.new }
  let(:runner) do
    pipe << ->(x) { gen.eval_string x }
      pipe << ->(x) { counter.process x }
    pipe << ->(x) { text_parse_valve x }
      pipe << ->(x){ inter.process x }
    pipe
  end

  describe 'page: h6, page: h6' do
    subject { runner.run "page { h6 'Page [= page] of [= page_count] pages'}; page { }" }
  end
end
