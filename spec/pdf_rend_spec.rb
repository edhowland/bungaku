# pdf_rend_spec.rb -  spec for PdfRend

require '../lib/pdfrend'
require 'minitest/autorun'

describe PdfRend do
    after { FileUtils.rm_f 'test.pdf' }
  let(:rend) { PdfRend.new('./test.pdf') }

  describe 'smoke test' do
      subject { rend.render [] }

  specify { subject }
end

  describe 'creates a test.pdf' do
    subject { rend.render [] }

  specify { subject; File.exist?('./test.pdf').must_equal true }
  end

  describe 'renders some text' do
    after do
      FileUtils.rm_f 'bandit.pdf'
    end
  let(:rend) { PdfRend.new('./bandit.pdf') }
    subject {  rend.render [[:para, [[:t, 'bandit']]]] }

    specify { subject }
  end
end
