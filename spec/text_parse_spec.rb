# text_parse_spec.rb - specs for TextParse


require_relative 'spec_helper'

describe TextParse do
    let(:parser) { TextParse.new }

  describe 'lexer empty string' do
    before do
      @actual = parser.lexer ''
    end

    it 'should be []' do

      @actual.must_equal []
    end
  end

  describe 'lexer 4 character string' do
    before do
      @actual = parser.lexer '1234'
    end

    it "should be ['1234']" do
      @actual.must_equal ['1234']
    end
  end


  describe 'lexer "abcd [ital def] ghi"' do
    before do
      @actual = parser.lexer 'abc [ital def] ghi'
    end
    it 'should be ["abc ", "ital def", "ghi"' do
      @actual.must_equal ['abc ', 'ital def', ' ghi']
  end
  end

  describe 'lexer "[bold hellow world]"' do
    subject { parser.lexer '[bold hello world]' }

    specify { subject.must_equal ['bold hello world'] }

  end

  describe 'chunker []' do
    before do
      @actual = parser.chunker []
    end

    it 'should be []' do
      @actual.must_equal []
    end
  end


  describe "chunker ['abc']" do
    before do
      @actual = parser.chunker ['abc']
    end

    it "should be  [[:t, 'abc']]" do
      @actual.must_equal [[:t, 'abc']]
    end
  end


  describe "chunker ['abc', 'def']" do
    before do
      @actual = parser.chunker ['abc', 'def']
    end

    it "should be [[:t, 'abc'], [:t, 'def']]" do
      @actual.must_equal [[:t, 'abc'], [:t, 'def']]
    end
  end

  describe "chunker ['abc ', 'ital def', ' ghi']" do
    before do
      @actual = parser.chunker ['abc ', 'ital def', ' ghi']
    end

    it "should be [[:t, 'abc '], [:ital, 'def'], [:t, ' ghi']]" do
      @actual.must_equal [[:t, 'abc '], [:ital, 'def'], [:t, ' ghi']]
    end
  end

  describe "chunker ['abcdef', 'bold ghi jkl']" do
    before do
      @actual = parser.chunker ['abcdef', 'bold ghi']
    end

    it "should be [[:t 'abcdef'], [:bold, 'ghi']]" do
      @actual.must_equal [[:t, 'abcdef'], [:bold, 'ghi']]
    end
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

    specify {subject.must_equal  [[:t, "Page "], [:t, "= page"], [:t, " of "], [:t, "= page_count"], [:t, " pages"]] }
  end
end
