# page_pipe_spec.rv - spec for page counterpipeline

require_relative 'spec_helper'


describe 'MdGen Pagination' do
  let(:gen) { MdGen.new }
  let(:counter) { PageCounter.new }
  let(:chain) { ->(x){gen.eval_string(x) } | ->(x){ counter.process(x) } } 

  describe 'empty page break with no block' do
    subject { chain.call_chain " page{}  " }

    specify { subject.must_equal [[:page, 1, 1]]}
  end
  describe 'should have page method taking a block' do
    subject { chain.call_chain " page { h1 'text' } " }

    specify {  subject.must_equal [[:h1, 'text'], [:page, 1, 1]] }
  end

  describe 'block with 2 page vlocks' do
    subject { chain.call_chain " page {}; page {} "}

  specify {  subject.must_equal [[:page, 1, 2], [:page, 2,2]]  }
  end

  describe 'passing variables to page blocks' do
    subject { chain.call_chain  " page {|page, total| para 'page: [= page], total: [= total]' } " }

  specify { subject.must_equal [[:para, [[:t, "page: "], [:equal, "page"], [:t, ", total: "], [:equal, "total"]]], [:page, 1, 1]]}
  end
end
