require_relative "objects/flower"

class TestScene < Scene

  def initialize
    super
    pink_flower = Flower.new Color.new(255,0,100)
    red_flower  = Flower.new Color.new(0,200,0)
    blue_flower = Flower.new Color.new(66, 135, 240)

    n = Node.new
    n.translate! Vector.new(1,0,1)
    n.add pink_flower
    add n

    n = Node.new
    n.translate! Vector.new(0,0,1)
    n.add red_flower
    add n

    n = Node.new
    n.translate! Vector.new(1,0,0)
    n.add blue_flower
    add n

  end

end
