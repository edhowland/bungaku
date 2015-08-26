# text_format_valve.rb - method text_format_valve

def is_heading? code
  [:h1, :h2, :h3, :h4, :h5, :h6].include? code[0]
end

# process code stream, formatting operands where needed
def text_format_valve codes
  fmtr = TextFormat.new
  codes.map_select(->(x){ is_heading?(x)}) {|e| e[1] = fmtr.format(e[1]); e # h1, h2, h3, h4, h5, h6
  }.map_select(->(x){ x[0] == :a})  {|e|name = e[1][0]; link = e[1][1]; name =  fmtr.format(name); [:a, [name, link]] } # link, :a
end
