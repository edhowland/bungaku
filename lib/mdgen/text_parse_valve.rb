# text_parse_valve.rb - method text_parse_valve wraps TextParse

def text_parse_valve codes
  parser = TextParse.new
  codes.map do |e|
    case e[0]
    when :h1, :h2, :h3, :h4, :h5, :h6
      e[1] = parser.parse e[1]
    when :ul, :ol
      e[1] = e[1].map {|f| parser.parse f }


  end
    e
  end
end
