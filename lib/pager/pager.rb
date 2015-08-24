# pager.rb - class Pager

class Pager
  def count_pages codes
    codes.reduce(0) {|i, j| (j[0] == :page ? i + 1 : i) }
  end

  def ennumber_pages codes, total=0
    #current = total
    #codes.reverse.map {|e|
      #if e[0] == :page
        ##r = [:page, current, total, e[1]]
        #current -= 1
        #r
      #else
        #e
      #end
    #}.reverse

    codes.map_param_select(1, ->(x){x[0] == :page}) {|i, j| [i+1,[:page, i, total, j[1]]] }  #[i+1, [:page, i, total, j[1]] }
  end

  def count_and_ennumber_pages codes
    ennumber_pages codes, count_pages(codes)
  end
end
