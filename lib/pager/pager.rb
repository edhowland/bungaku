# pager.rb - class Pager

class Pager
  def count_pages codes
    codes.reduce(0) {|i, j| (j[0] == :page ? i + 1 : i) }
  end

  def ennumber_pages codes, total=0
    codes.map_param_select(1, ->(x){x[0] == :page}) {|i, j| [i+1,[:page, i, total, j[1]]] }  #[i+1, [:page, i, total, j[1]] }
  end

  def count_and_ennumber_pages codes
    ennumber_pages codes, count_pages(codes)
  end

  def call_lambda codes
    codes.map_select(->(x){ x[0] == :page}) {|e|
       [:page, e[1], e[2], MdGen.new.process(e[1],e[2], &e[3])]
    }
  end


  # split out inner page content and the page element
  def split_content_and_page codes
    codes
  end
end
