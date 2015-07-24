# nested_headings_spec.rb - spec for markdownnested blocks

require '../lib/mdgen'
require 'minitest/autorun'

describe 'Nested Heading' do
  let(:gen) { MdGen.new }

  describe 'no nested' do
    subject { gen.process { h 1,  'head' } }

  specify { subject.must_equal [[:h1, 'head']] }
  end

  describe 'two nests' do
    subject do 
      gen.process { h(1, 'head1') {|l|  h(l, 'head2')} }
    end

    specify {  subject.must_equal [[:h1, 'head1'], [:h2, 'head2']] }
end

  describe '6 nested headings' do
    subject do
      gen.process do
        h 1, 'h1' do |l|
            h l, 'h2' do |l|
             h(l, 'h3') {|l|  h(l, 'h4') {|l| h(l, 'h5') {|l| h(l, 'h6') } } }
              end
        end
      end
    end

    specify { subject.must_equal [
      [:h1, 'h1'],
      [:h2, 'h2'],
      [:h3, 'h3'],
      [:h4, 'h4'],
      [:h5, 'h5'],
      [:h6, 'h6']

      ] }
  end

  describe 'complicated nestedings' do
    subject { gen.process { h(1, 'h1') {|l| h l, 'h2' }; h(1, 'h1') {|l| h(l, 'h2') } } }

  specify { subject.must_equal [[:h1, 'h1'], [:h2, 'h2'], [:h1, 'h1'], [:h2, 'h2']] }
  end

  describe 'must raise MdGen::NestingTooDeep if > 6 levels' do
    # we set a lambda for the subject. When run, it should raise exception
    subject { ->{ gen.process { h 7, 'bad head' } } }

  specify { subject.must_raise MdGen::NestingTooDeep }
  end
  describe '7 nested headings raises exception' do
    subject do
      Proc.new do
      gen.process do
        h 1, 'h1' do |l|
            h l, 'h2' do |l|
             h(l, 'h3') {|l|  h(l, 'h4') {|l| h(l, 'h5') {|l| h(l, 'h6') {|l| h(l, 'bad')} } } }
              end
        end
      end
      end
    end

    specify { subject.must_raise MdGen::NestingTooDeep }
  end

  describe 'simple string heading' do
    subject { gen.eval_string 'h 1, "head"' }

    specify { subject.must_equal [[:h1, 'head']] }
  end
end
