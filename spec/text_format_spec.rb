# text_format_spec.rb  - spec for class TextFormat

require '../lib/mdgen'
require 'minitest/autorun'

describe TextFormat do
  before { @f = TextFormat.new }

  describe 'format []' do
    subject { @f.format [] }

    specify { subject.must_equal '' }
  end

  describe "format [[:t, 'text']]" do
    subject { @f.format [[:t, 'text']] }

    specify { subject.must_equal 'text' }

  end


  describe "format [[:bold 'text']]" do
    subject { @f.format [[:bold, 'text']] }

    specify { subject.must_equal '**text**' }
  end

  describe "format [[:ital some words']]" do
    subject {@f.format [[:ital, 'some words']] }

    specify { subject.must_equal '*some words*' }
  end

  describe 'complicated input with text, bold and itlics' do
    subject { @f.format [[:t, 'Now is the '],
        [:ital, 'time'],
        [:t, ' for all good '],
        [:bold, 'Men']
]}

    specify { subject.must_equal 'Now is the *time* for all good **Men**' }
  end
end
