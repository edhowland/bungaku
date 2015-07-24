# md_kit.rb - MdKit a renderrer to Markdown

class MdKit

  def h1 text
  puts "# #{text}"
  end

  def h2 text
    puts "## #{text}"
  end

  def code text
    puts '```'
    puts text
    puts '```'
  end

  def ol list
    list.each_with_index do |e, i|
      puts "#{i+1}. #{e}"
    end
  end

  def ul list
    list.each do |e|
      puts "- #{e}"
    end
  end

  def para string
    puts string
  end

alias_method :text, :para

  def a title, url
    print "[#{title}](#{url})"
  end
  def render codes
    codes.each do |e|
      if e[0] == :a
      a(e[1], e[2])
    else
        self.send e[0], e[1]
    end
      puts
    end
  end
end
