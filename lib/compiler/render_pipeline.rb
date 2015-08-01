# render_pipeline.rb - class RenderPipeline

class RenderPipeline
  def initialize
  @pipeline = []
  end

  attr_reader :pipeline

  def << proc
    @pipeline << proc
  end

  def run initial=nil, &blk
    initial = blk if block_given?
    @pipeline.reduce(initial) {|i, j| j.call(i) }
  end
end
