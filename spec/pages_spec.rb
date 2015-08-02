# pages_spec.rb - spec for adding pages

require_relative 'spec_helper'


describe PageCounter do
  let(:counter) { PageCounter.new }

  describe 'should have 0 pages' do
    subject { c=counter; c.process []; c }

    specify { subject.page_count.must_equal 0 }
  end

  describe 'with Bungaku::VERSION' do
    subject { c=counter; c.process [[ :para, Bungaku::VERSION]];  c }

    specify { subject.page_count.must_equal 0 }
  end

describe 'multiple pages' do
    subject {c=counter; c.process [[:page, 0, 0], [:page, 0, 0]];  c}

    specify { subject.page_count.must_equal 2  }
  end

  describe 'with head , para d and no pages' do
    subject { c=counter; c.process [[:h1, 'header'], [:para, '']]; c}

    specify { subject.page_count.must_equal 0}
  end
  describe 'block with h1, 2 pages block with inner primatives' do
    subject { c=counter; c.process [[:h2, ''], [:page, 0, 0], [:para, ''], [:page, 0, 0], [:code, '']]; c}

    specify { subject.page_count.must_equal 2 }
  end 

  describe 'pass codes array unchanged' do
    let(:codes) { [[:h1, 'Header 1'],  [:code, 'some shell stuff'],  [:para, '']] }
    subject { c=counter; c.process codes}

  specify { subject.must_equal codes }
  end
end

