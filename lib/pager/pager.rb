# pager.rb - class Pager

class Pager
  def count_pages codes
    codes.reduce(0) {|i, j| (j[0] == :page ? i + 1 : i) }
  end

  def ennumber_pages codes, total=0
    current = total
    codes.reverse.map {|e|
      if e[0] == :page
        r = [:page, current, total, e[1]]
        current -= 1
        r
      else
        e
      end
    }.reverse
  end
end
