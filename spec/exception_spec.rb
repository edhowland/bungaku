# exception_spec.rb - test for raising exceptions

require 'minitest/autorun'

describe 'must raise' do
  it 'should raise' do
    -> { raise RuntimeError }.must_raise RuntimeError
  end
end
