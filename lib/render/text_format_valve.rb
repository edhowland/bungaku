# text_format_valve.rb - method text_format_valve

def is_heading? code
  [:h1, :h2, :h3, :h4, :h5, :h6].include? code[0]
end

# process code stream, formatting operands where needed
def text_format_valve codes
  fmtr = TextFormat.new
  codes.map_select(->(x){ is_heading?(x)}) {|e| e[1] = fmtr.format(e[1]); e }
end
