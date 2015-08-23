# integrate_gen_count_parse_spec.rb - specs for integrate_gen_count_parse

require_relative 'spec_helper'

describe 'MdGen -> PageCounter -> TextParse' do
  let(:gen) { MdGen.new }
  let(:counter) { PageCounter.new }
    let(:inter) { InterpolateVariables.new }
  let(:chain) {
    ->(x){ gen.eval_string(x) } | 
    ->(x){ counter.process(x) } | 
    ->(x){ text_parse_valve x } |  
    ->(x){ inter.process(x) }
  }
  #let(:runner) do
    #pipe << ->(x) { gen.eval_string x }
      #pipe << ->(x) { counter.process x }
    #pipe << ->(x) { text_parse_valve x }
      #pipe << ->(x){ inter.process x }
    #pipe
  #end

  describe 'page: h6, page: h6' do
    subject {chain.call_chain  "page { h6 'Page [= page] of [= page_count] pages'}; page { }" }
    specify {subject.must_equal  [
      [:h6, ''] 
    ] }
  end
end
