# page_counter.rb - class PageCounter

class PageCounter 
  def initialize
    @page_count = 0
  end

  attr_reader :page_count



  def process codes
  @page_counter = codes.reduce(0) {|i, j| i + 1 if j[0] == :page }
    codes
  end

end
