# render_pipeline_spec.rb - specs for render_pipeline

require_relative 'spec_helper'

describe RenderPipeline do
  let(:pipe) { RenderPipeline.new }
  describe '<<' do
    subject do
      r = pipe
     r << ->(x){ x} 
      r
    end

  specify { subject.pipeline[0].must_be_instance_of Proc }
  end

  describe 'run 1' do
    let(:runner) { p=pipe; p<< ->(x) { x }; p }
    subject { runner.run 1 }

    specify { subject.must_equal 1 }
  end
end
