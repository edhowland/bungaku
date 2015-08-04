# text_parse_valve.rb - method text_parse_valve wraps TextParse

def text_parse_valve codes
  parser = TextParse.new
  codes.map do |e|
    if e.first == :h1
      e[1] = parser.parse e[1]
  end
    e
  end
end
