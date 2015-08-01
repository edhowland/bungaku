# render_pipeline.rb - class RenderPipeline

class RenderPipeline
  def initialize
  @pipeline = []
  end

  attr_reader :pipeline

  def << proc
    @pipeline << proc
  end
end
