# integrate_parse_format_spec.rb - spec for both TextParse, TextFormat

require '../lib/mdgen'
require 'minitest/autorun'

describe 'Format a Parsed input string' do
  before do
    @p=TextParse.new
    @f = TextFormat.new
  end

  describe 'empty input' do
    subject { @f.format @p.parse('') }

    specify { subject.must_equal '' }
  end

  describe 'simple text input' do
    subject { @f.format @p.parse('text') }

    specify { subject.must_equal 'text' }
  end

  describe "embedded bold 'this is [bold vold] text'" do
    subject { @f.format @p.parse('this is [bold bold] text') }

    specify { subject.must_equal 'this is **bold** text' }
  end

  describe 'really complicated example' do
    subject { @f.format @p.parse('[bold ATTENTION]! Now hear [ital this]') }

  specify { subject.must_equal '**ATTENTION**! Now hear *this*' }

  end

end
