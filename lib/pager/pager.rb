# pager.rb - class Pager

class Pager
  def count_pages codes
    codes.reduce(0) {|i, j| (j[0] == :page ? i + 1 : i) }
  end

  def ennumber_pages codes, total=0
    current = total
    codes.reverse.map {|e| e }.reverse
  end
end
