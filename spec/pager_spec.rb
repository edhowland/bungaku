# pager_spec.rb - specs for pager

require_relative 'spec_helper'

describe Pager do
  let(:pager) { Pager.new }

  describe 'count_pages' do
    let(:codes0) { [] }
    let(:codes2) { [[:page, nil], [:page, nil]] }
    let(:counter0) { pager.count_pages codes0 }
    subject { pager.count_pages codes2 }

     specify { counter0.must_equal 0 }
    specify { subject.must_equal 2 }
  end

  describe 'complex count_pages' do
    let(:codes) { [[:para, ''], [:page, nil], [:code, ''], [:page, nil]] }  
    subject { pager.count_pages codes }

    specify { subject.must_equal 2 }
  end
end
