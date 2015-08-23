# pager_spec.rb - specs for pager

require_relative 'spec_helper'

describe Pager do
  let(:pager) { Pager.new }

  describe 'count_pages' do
    let(:codes) { [[:page, nil], [:page, nil]] }
    subject { pager.count_pages codes }

    specify { subject.must_equal 2 }
  end

end
