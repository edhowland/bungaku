# gfm_render_spec.rb - spec for GfmRender

require '../lib/mdgen'
require 'minitest/autorun'

describe GfmRender do
  before { @r = GfmRender.new }
  let(:rend) { GfmRender.new }

  describe 'render empty codes' do
    subject { @r.render [] }

    specify { subject.must_equal '' }
  end

describe 'heading 1' do
    subject { @r.render [[:h1, 'head']] }

    specify { subject.must_equal "# head\n\n" }
  end

  describe 'heading 2' do
   subject { @r.render [[:h2, 'head' ]] }

  specify { subject.must_equal "## head\n\n" }
  end

  describe 'heading 3' do
    subject { @r.render [[:h3, 'head']] }

    specify { subject.must_equal "### head\n\n" }
  end


  describe 'heading 4' do
    subject { @r.render [[:h4, 'head']] }

  specify { subject.must_equal "#### head\n\n" }
  end

describe 'heading 5' do
    subject { @r.render [[:h5, 'head']] }

    specify { subject.must_equal "##### head\n\n" }
  end

  describe 'heading 6' do
    subject { @r.render [[:h6, 'head']] }

    specify { subject.must_equal "###### head\n\n" }
  end

  describe 'single code code' do
    subject { @r.render [[:code, '']] }

    specify { subject.must_equal "\`\`\`\n\n\`\`\`\n\n" }
  end

  describe 'code with text' do
    subject { @r.render [[:code, 'text']] }

    specify { subject.must_equal "\`\`\`\ntext\n\`\`\`\n\n" }
  end

  describe 'paragraph must be separated by blank line' do
    subject { @r.render [[:para, [[:t, 'text']]]] }

    specify { subject.must_equal "text\n\n" }

  end

  describe '2 headings' do
    subject { @r.render [[:h1, 'head 1'], [:h2, 'head 2']] }

  specify { subject.must_equal "# head 1\n\n## head 2\n\n" }
  end

  describe 'heading and para' do
    subject { @r.render [[:h1, 'head'], [:para, [[:t, 'text']]]] }
  end

  describe 'two elements : code, text' do
    subject { @r.render [[:code, 'code'], [:para, [[:t, 'text']]]] }

    specify { subject.must_equal "\`\`\`\ncode\n\`\`\`\n\ntext\n\n" }
  end

  describe 'head, para and code' do
    subject { @r.render [[:h2, 'heading'], [:para, [[:t, 'brown fox']]], [:code, 'code']] }  

    specify { subject.must_equal "## heading\n\nbrown fox\n\n\`\`\`\ncode\n\`\`\`\n\n" }
  end

  describe 'one complicated paragraph' do
    subject { @r.render [[:para, 
      [[:t, 'the '],
       [:bold, 'quick'], 
        [:t, ' brown fox']
      ]]] }

    specify {subject.must_equal "the **quick** brown fox\n\n" }
  end


  describe 'bullets' do
    subject { @r.render [[:ul, ['a', 'b']]] }

  specify { subject.must_equal "- a\n- b\n\n" }
  end

  describe 'numbers' do
    subject { @r.render [[:ol, ['1', '2']]] }

  specify  { subject.must_equal "1. 1\n2. 2\n\n" }
  end

  describe 'link' do
    subject { @r.render [[:a, ['title', 'url']]] }

  specify { subject.must_equal "[title](url)\n"  }
  end

  describe 'ignore pages' do
    subject { @r.render [[:page, 1, 1]] }

  specify { subject.must_equal '' }
  end


  describe 'inserting dashes into array' do
    subject { rend.insert_dashes [['a'],['b']] }

    specify { subject.must_equal  [['a'], ['----'], ['b'] ] }
  end

describe 'insert correct column numbers of dashes' do
    subject {rend.insert_dashes [['a', 'a'], ['b', 'b']]  }

    specify { subject.must_equal [['a', 'a'], ['----', '----'], ['b', 'b']]  }
end
  describe 'render table' do
    subject { rend.render [[:table, [
      ['head','head'],
        ['cell 1', 'cell 2'],
        ['row 2', 'col 2']
      ]]] }

    specify {  subject.must_equal"head|head\n----|----\ncell 1|cell 2\nrow 2|col 2\n\n"  }
  end

  describe 'html_table' do
    subject { rend.render [[:html_table, [], {} ]] }

    specify { subject.must_equal "<table></table>\n\n" }
  end

  describe 'html_table with one row' do
    subject { rend.render [[:html_table, [['H']],  {} ]] }

    specify { subject.must_equal "<table>\n<tr><td>H</td></tr></table>\n\n" }
  end

  describe 'html_table with 2 rows and 2 columns each' do
    subject { rend.render [[:html_table, [
        ['H1', 'H2'],  # row 0
        ['C1', 'C2']  # row 1
      ], {} ]] }

    specify { subject.must_equal "<table>\n<tr><td>H1</td><td>H2</td></tr>\n<tr><td>C1</td><td>C2</td></tr></table>\n\n"}
  end

  describe 'html_width' do
    subject { rend.html_table [], width: '100%' }

    specify { expected = "<table width=\"100%\"></table>\n"
 subject.must_equal expected}
  end
end
