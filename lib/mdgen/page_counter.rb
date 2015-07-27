# page_counter.rb - class PageCounter

class PageCounter < CodeCompiler
  def initialize
    super
    @page_count = 0
  end

  attr_reader :page_count

def page *args, &blk
  @page_count += 1
  end

  def eval_string string
    self.instance_eval string
    @codes
  end

  def process(&blk)
    self.instance_exec &blk
    @page_count
  end

  def method_missing *args
  end
end
