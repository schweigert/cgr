require_relative "gameobject"

class Flower < GameObject

  def initialize color
    super()

    @size = 30

    # tail
    add Vector.new(0,0,0), Color.new(65,135,51)
    add Vector.new(0,0.5,0), Color.new(65,135,51)
    add Vector.new(0,1,0), Color.new(65,135,51)

    # center
    add Vector.new(0,1.5,0), Color.new(250, 255, 0)

    #petals
    add Vector.new(0.5, 1, 0.5), color
    add Vector.new(0.5, 1, -0.5), color
    add Vector.new(-0.5, 1, 0.5), color
    add Vector.new(-0.5, 1, -0.5), color

    add Vector.new(0.25, 1.25, 0.25), color
    add Vector.new(0.25, 1.25, -0.25), color
    add Vector.new(-0.25, 1.25, 0.25), color
    add Vector.new(-0.25, 1.25, -0.25), color

    compile

  end

end
