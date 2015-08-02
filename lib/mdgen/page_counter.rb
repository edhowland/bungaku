# page_counter.rb - class PageCounter

class PageCounter 
  def initialize
    @page_count = 0
  end

  attr_reader :page_count



  def process codes
  @page_count = codes.select {|e| e[0] == :page }.length
    codes
  end

end
