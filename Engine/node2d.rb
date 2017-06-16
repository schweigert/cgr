require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

require_relative 'vector'

class Node2D

  attr_accessor :position, :rotation, :scale

  def initialize
    @position = Vector.new
    @rotation = 0
    @scale    = Vector.new 1,1
    @nodes    = []
  end

  def translate! v
    @position = @position + v
  end

  def translate v
    @position = v
  end

  def rotate! a
    @rotation += a
  end

  def rotate a
    @rotate = a
  end

  def resize! v
    @scale = @scale + a
  end

  def resize v
    @scale = v
  end

  def << obj
    @nodes << obj
  end

  def draw
    glutSolidCube 1
  end

  def onRender

    glPushMatrix
      glTranslatef @position.x, @position.y, 0
      glRotatef @rotation, 0, 0, 1

      for i in @nodes
        i.onRender
      end

      glScalef @scale.x, @scale.y, 1
      draw

    glPopMatrix
  end

  def onIdle deltaTime
    translate!(Vector.new(1,0)*deltaTime)
    for i in @nodes
      i.onIdle deltaTime
    end
  end

end
