# code_compiler.rb - class CodeCompiler

class CodeCompiler
  def initialize
    @codes = []
    @codes.extend EnumerableMapParam
  end

  attr_reader :codes
end
