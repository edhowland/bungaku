# text_parse_spec.rb - specs for TextParse


require_relative 'spec_helper'

describe TextParse do
    let(:parser) { TextParse.new }

  describe 'lexer empty string' do
      subject {  parser.lexer '' }

    specify {subject.must_equal [] }
  end

  describe 'lexer 4 character string' do
      subject {  parser.lexer '1234' }

      specify { subject.must_equal ['1234'] }
  end


  describe 'lexer "abcd [ital def] ghi"' do
      subject {parser.lexer 'abc [ital def] ghi' }

    specify { subject.must_equal ['abc ', 'ital def', ' ghi'] }
  end

  describe 'lexer "[bold hellow world]"' do
    subject { parser.lexer '[bold hello world]' }

    specify { subject.must_equal ['bold hello world'] }

  end

  describe 'chunker []' do
      subject { parser.chunker [] }

      specify { subject.must_equal []}
  end


  describe "chunker ['abc']" do
      subject {  parser.chunker ['abc'] }

      specify { subject.must_equal [[:t, 'abc']] }
  end

  describe "chunker ['abc', 'def']" do
      subject {  parser.chunker ['abc', 'def'] }

      specify { subject.must_equal [[:t, 'abc'], [:t, 'def']] }
  end

  describe "chunker ['abc ', 'ital def', ' ghi']" do
      subject {  parser.chunker ['abc ', 'ital def', ' ghi'] }

      specify { subjec.must_equal [[:t, 'abc '], [:ital, 'def'], [:t, ' ghi']] }
  end

  describe "chunker ['abcdef', 'bold ghi jkl']" do
      subject {  parser.chunker ['abcdef', 'bold ghi'] }

specify {      @actual.must_equal [[:t, 'abcdef'], [:bold, 'ghi']] }
  end

  describe 'parse "abc [bold def] ghi jkl"' do
    subject { parser.parse 'abc [bold def] ghi jkl' }
    specify { subject.must_equal [[:t, 'abc '], [:bold, 'def'], [:t, ' ghi jkl']] }
  end


  describe 'parse "[bold ab] def [ital ghi] jkl"' do
    subject { parser.parse '[bold ab] def [ital ghi] jkl' }

  specify { subject.must_equal [
      [:bold, 'ab'],
      [:t, ' def '],
      [:ital, 'ghi'],
      [:t, ' jkl']
  ] }

  end

  # pass through [= variable]
  describe '[= page]' do
    subject { parser.parse 'Page [= page] of [= page_count] pages' }

    specify {subject.must_equal  [[:t, "Page "], [:equal, "page"], [:t, " of "], [:equal, "page_count"], [:t, " pages"]] }
  end
end
