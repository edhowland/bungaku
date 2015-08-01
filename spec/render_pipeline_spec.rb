# render_pipeline_spec.rb - specs for render_pipeline

require_relative 'spec_helper'

describe RenderPipeline do
  let(:pipe) { RenderPipeline.new }
  describe '<<' do
    subject do
     pipe << ->(x){ x} 
    end

  specify { subject.pipeline[0].nust_be_instance_of Proc }
  end



end
