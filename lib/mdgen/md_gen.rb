# mdgen.rb - MdGen class DSL to generate Markdown


class PageCounter < CodeCompiler
  def initialize
    @page_count = 0
  end

  attr_reader :page_count

def page *args, &blk
  @page_count += 1
  end

  def eval_string string
    self.instance_eval string
  end

  def process(&blk)
    self.instance_exec &blk
    @page_count
  end

  def method_missing *args
  end
end


class MdGen < CodeCompiler
  class NestingTooDeep < RuntimeError
    def initialize
      super('Nesting Level Too Deep')
    end
  end

  def initialize
  super
  @page_count = 0
    @page_current = 0
  end


  def h l,  string, &blk
     raise MdGen::NestingTooDeep if l > 6

    headm = "h#{l}".to_sym
    @codes << [headm, string]
  yield l + 1 if block_given?
    @codes
  end
  def h1 string
    @codes << [:h1, string]
  end

  def h2 string
    @codes << [:h2, string]
  end

  def h3 string
    @codes << [:h3, string]
  end

  def h4 string
    @codes << [:h4, string]
  end

  def h5 string
    @codes << [:h5, string]
  end

  def h6 string
    @codes << [:h6, string]
  end

  def code string
    @codes << [:code, string]
  end

def para string
  parser = TextParse.new
  
    @codes << [:para, parser.parse(string)]
  end

  alias_method :text, :para

  def ordered_list(*list)
  list = list[0] if list[0].instance_of? Array
    @codes << [:ol, list]
  end

alias_method :numbers, :ordered_list

  def bullets *list
      @codes << [:ul, list]
  end

  def link title, url
    @codes << [:a, [title, url]]
  end

  def page(&blk)
    @page_current += 1
  yield @page_current, @page_count if block_given?
    @codes << [:page, @page_current, @page_count]
  end

  def table arr
    @codes << [:table, arr]
  end

  def html_table arr, options={}
    @codes << [:html_table, arr, options]
  end

  # import a .mdsl file, process it and add opcodes to our @codes
  def import filename
  blk_str = File.read filename
    blk = eval blk_str
  self.instance_exec &blk
  end

  def eval_string string
    @page_count = PageCounter.new.eval_string string
    self.instance_eval string
  end

  # process the block which contains the MDSL commads returning array of opcodes
def process(&blk)
    # count pages first
    @page_count = PageCounter.new.process(&blk)
    self.instance_exec &blk
    @codes
  end  

  # render the output as proper markdown
  # pass a renderer
  def render kit
    kit.render @codes
  end
end
