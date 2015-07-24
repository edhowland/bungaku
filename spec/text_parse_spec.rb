# text_parse_spec.rb - specs for TextParse


require '../lib/mdgen'
require 'minitest/autorun'

describe TextParse do
  before do
    @p = TextParse.new
  end

  describe 'lexer empty string' do
    before do
      @actual = @p.lexer ''
    end

    it 'should be []' do

      @actual.must_equal []
    end
  end

  describe 'lexer 4 character string' do
    before do
      @actual = @p.lexer '1234'
    end

    it "should be ['1234']" do
      @actual.must_equal ['1234']
    end
  end


  describe 'lexer "abcd [ital def] ghi"' do
    before do
      @actual = @p.lexer 'abc [ital def] ghi'
    end
    it 'should be ["abc ", "ital def", "ghi"' do
      @actual.must_equal ['abc ', 'ital def', ' ghi']
  end
  end

  describe 'lexer "[bold hellow world]"' do
    subject { @p.lexer '[bold hello world]' }

    specify { subject.must_equal ['bold hello world'] }

  end

  describe 'chunker []' do
    before do
      @actual = @p.chunker []
    end

    it 'should be []' do
      @actual.must_equal []
    end
  end


  describe "chunker ['abc']" do
    before do
      @actual = @p.chunker ['abc']
    end

    it "should be  [[:t, 'abc']]" do
      @actual.must_equal [[:t, 'abc']]
    end
  end


  describe "chunker ['abc', 'def']" do
    before do
      @actual = @p.chunker ['abc', 'def']
    end

    it "should be [[:t, 'abc'], [:t, 'def']]" do
      @actual.must_equal [[:t, 'abc'], [:t, 'def']]
    end
  end

  describe "chunker ['abc ', 'ital def', ' ghi']" do
    before do
      @actual = @p.chunker ['abc ', 'ital def', ' ghi']
    end

    it "should be [[:t, 'abc '], [:ital, 'def'], [:t, ' ghi']]" do
      @actual.must_equal [[:t, 'abc '], [:ital, 'def'], [:t, ' ghi']]
    end
  end

  describe "chunker ['abcdef', 'bold ghi jkl']" do
    before do
      @actual = @p.chunker ['abcdef', 'bold ghi']
    end

    it "should be [[:t 'abcdef'], [:bold, 'ghi']]" do
      @actual.must_equal [[:t, 'abcdef'], [:bold, 'ghi']]
    end
  end

  describe 'parse "abc [bold def] ghi jkl"' do
    subject { @p.parse 'abc [bold def] ghi jkl' }
    specify { subject.must_equal [[:t, 'abc '], [:bold, 'def'], [:t, ' ghi jkl']] }
  end


  describe 'parse "[bold ab] def [ital ghi] jkl"' do
    subject { @p.parse '[bold ab] def [ital ghi] jkl' }

  specify { subject.must_equal [
      [:bold, 'ab'],
      [:t, ' def '],
      [:ital, 'ghi'],
      [:t, ' jkl']
  ] }

  end
end
