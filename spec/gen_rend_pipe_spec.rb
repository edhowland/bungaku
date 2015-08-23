# gen_rend_pipe_spec.rb - specs for gen_rend_pipe

require_relative 'spec_helper'

describe 'generate, then render' do
  let(:chain) {->(x) { MdGen.new.eval_string(x) } | ->(x) { GfmRender.new.render(x) } }

  
end
