# subject_spec.rb

require "minitest/autorun"

describe Array do
  subject { Array.new }

  it 'should be length 0' do
    subject.length.must_equal 0
  end
end
