# pager_spec.rb - specs for pager

require_relative 'spec_helper'


def e(arr)
  arr.extend EnumerableMapParam
  arr
end

describe Pager do
  let(:pager) { Pager.new }

  describe 'count_pages' do
    let(:codes0) { e([])}
    let(:codes2) { e( [[:page, nil], [:page, nil]]) }
    let(:counter0) { pager.count_pages codes0 }
    subject { pager.count_pages codes2 }

     specify { counter0.must_equal 0 }
    specify { subject.must_equal 2 }
  end

  describe 'complex count_pages' do
    let(:codes0) {e([[:para, ''], [:code, ''], [:a, '', '']]) }
    let(:codes) {e( [[:para, ''], [:page, nil], [:code, ''], [:page, nil]]) }  
    let(:counter0) { pager.count_pages codes0 }
    subject { pager.count_pages codes }

    specify { counter0.must_equal 0 }
    specify { subject.must_equal 2 }
  end

  describe 'ennumber_pages []' do
    subject { pager.ennumber_pages e([]) }

    specify { subject.must_equal [] }
  end

  describe 'ennumber_pages with no pages' do
    let(:codes) { e([[:para, ''], [:code, '']]) }
    subject { pager.ennumber_pages codes }

    specify { subject.must_equal codes }
  end

  describe 'ennumber_pages' do
    let(:codes) { e([[:page, nil], [:page, nil]]) }
    subject { pager.ennumber_pages codes, 2 }

    specify { subject.must_equal [[:page, 1,2, nil], [:page, 2,2, nil]] }
  end


  describe 'count_and_ennumber_pages' do
    let(:codes) { e([[:page, nil], [:page, nil], [:page, nil]]) }
    subject { pager.count_and_ennumber_pages codes }

  specify { subject.must_equal [[:page, 1, 3, nil], [:page, 2, 3, nil], [:page, 3, 3, nil]] }
  end

  describe 'count_and_ennumber_pages []' do
    subject { pager.count_and_ennumber_pages e([]) }
    specify { subject.must_equal [] }
  end

  describe 'count_and_ennumber_pages with no pages' do
    let(:codes) { e([[:a, '', ''], [:ul, []], [:ol, ['', '']], [:para, '']]) }
    subject { pager.count_and_ennumber_pages codes }

    specify { subject.must_equal codes }
  end
end
