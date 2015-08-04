# text_parse_valve.rb - method text_parse_valve wraps TextParse

def text_parse_valve codes
  parser = TextParse.new
  codes.map do |e|
    case e[0]
    when :h1
      e[1] = parser.parse e[1]
    when :ul
      e[1] = e[1].map {|f| parser.parse f }


  end
    e
  end
end
