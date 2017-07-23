require_relative 'vector'

class Node

  attr_reader :position, :rotation

  def initialize
    @position = Vector.new
    @rotation = Vector.new
    @nodes = []
  end

  def add e
    @nodes << e
  end

  def translate v
    @position = v
  end

  def translate! v
    @position = @position + v
  end

  def rotate r
    @rotation = r
  end

  def rotate! r
    @rotation = @rotation + r
  end

  def render
    glPushMatrix
    glTranslatef @position.x, @position.y, @position.z
    for i in @nodes
      i.render
    end
    glPopMatrix
  end

  def update
    for i in @nodes
      i.update
    end
  end

end
