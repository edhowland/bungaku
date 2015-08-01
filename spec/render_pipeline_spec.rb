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
end
