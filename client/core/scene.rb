require_relative "node"
require_relative "color"
require_relative "vector"
require_relative "camera"

class Scene < Node

  def initialize
    super

    @camera = Camera.new
    $cam = @camera
    @camera.translate Vector.new(5,5,5)
    @camera.lookAt Vector.new(0,1,0)


  end

  def render
    @camera.render

    super
  end

  def update t
    super
  end

end
