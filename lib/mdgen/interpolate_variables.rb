# interpolate_variables.rb - class InterpolateVariables

class InterpolateVariables
  def interpolate sub_a
    sub_a
  end

  def process codes
    codes.map do |e|
      case e[0]
      when :h1, :h2, :h3, :h4, :h5, :h6
        e[1] = interpolate e[1]
      when :ul, :ol, :a
        e[1] = nterpolate  e[1]
      end

      e           
    end
  end

end
