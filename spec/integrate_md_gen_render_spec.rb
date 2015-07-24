# integrate_md_gen_render_spec.rb - spec to combine MdGen, GfmRender

require '../lib/mdgen'
require 'minitest/autorun'

describe 'Integration test: MdGen, GfmRender' do
  let(:gen) { MdGen.new }
  let(:rend) { GfmRender.new }

  describe 'simple code element' do
    subject { rend.render(gen.process { code 'code' }) }

specify { subject.must_equal <<-EOC
\`\`\`
code
\`\`\`

EOC
}
  end


  describe 'three paragraphs' do
    subject { rend.render gen.process { para 'text1'; para 'text2'; para 'text3' } }

    specify { subject.must_equal"text1\n\ntext2\n\ntext3\n\n"  }
  end

  describe '2 code elements' do
    subject { rend.render gen.process { code 'code1'; code 'code2' } }

    specify { subject.must_equal "\`\`\`\ncode1\n\`\`\`\n\n\`\`\`\ncode2\n\`\`\`\n\n"  }
  end
describe 'simple two elements: para, code' do
    subject { rend.render gen.process { para 'text'; code 'code' } } 

    specify { subject.must_equal "text\n\n\`\`\`\ncode\n\`\`\`\n\n" }
  end

  describe 'code then para' do
    subject { rend.render gen.process { code 'code'; para 'text' } }

  specify { subject.must_equal "\`\`\`\ncode\n\`\`\`\n\ntext\n\n" }
  end

describe 'para, code and para' do
    subject { rend.render gen.process { para 'text'; code 'code'; para 'text' } }

  specify { subject.must_equal "text\n\n\`\`\`\ncode\n\`\`\`\n\ntext\n\n" }
  end

  describe 'para with bold and ital, code, para' do
    subject { rend.render gen.process { para 'the [bold quick] brown [ital fox]'; code 'code' ; para 'text' } }  

  specify { subject.must_equal "the **quick** brown *fox*\n\n\`\`\`\ncode\n\`\`\`\n\ntext\n\n" }
  end
    end
