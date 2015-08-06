# interpolate_variables_spec.rb - specs for interpolate_variables

require_relative 'spec_helper'

describe InterpolateVariables do
  let(:inter) { InterpolateVariables.new }

  describe 'process' do
    subject { inter.process [[:h1, [[:equal, 'page_no']]   ]]}

    specify { subject.must_equal [[:h1, [[:t, '1']] ]] }
  end
end
