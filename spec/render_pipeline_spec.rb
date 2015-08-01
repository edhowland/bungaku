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

  describe 'run 1; returns 2' do
    let(:runner) { p=pipe; p << ->(x) { x + 1 }; p }
    subject { runner.run 1 }

    specify { subject.must_equal 2 }
  end

  describe 'run with block' do
    let(:runner) { p=pipe; p << ->(x) { x.call }; p }
    subject { runner.run { 'x' } }

    specify { subject.must_equal 'x' }
  end

  describe 'run "AA BB CC"' do
    let(:runner) do
      p = pipe
      p << ->(x) { x.split }
      p << ->(x) { x.map {|e| e.downcase } }
      p << ->(x) { x.join('-') }
      p
    end
    subject { runner.run 'AA BB CC' }

    specify { subject.must_equal 'aa-bb-cc' }
  end
end
