# proc_chain_spec.rb - specs for proc_chain

require_relative 'spec_helper'

describe Proc do
  describe '| - pipe' do
    let(:add1) { ->(x){ x + 1} }
    let(:sub1) { ->(x){ x - 1} }
    let(:add2) { ->(x){ x + 2} }

    let(:chain) { add1 | add2 | sub1 }
    subject { chain; add1.call_chain 1 }

  specify { subject.must_equal 3 }
  end
end
