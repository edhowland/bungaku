# render_pipeline.rb - class RenderPipeline

class RenderPipeline
  def initialize
  @pipeline = []
  end

  attr_reader :pipeline

  def << proc
    @pipeline << proc
  end

  def run initial
    @pipeline.reduce(initial) {|i, j| j.call(i) }
  end
end
