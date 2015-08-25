# gen_rend_pipe_spec.rb - specs for gen_rend_pipe

require_relative 'spec_helper'

describe 'generate, then render' do
  let(:lgen) { ->(x){ MdGen.new.eval_string(x) } }
  let(:chain) { lgen | ->(x) { GfmRender.new.render(x) }; lgen }

  describe 'h1 to # heading 1' do
    subject { chain.call_chain("h1 'heading 1'") }

    specify { subject.must_equal "# heading 1\n\n" }
  end
end
