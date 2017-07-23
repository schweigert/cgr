require 'gl'
require 'glu'
require 'glut'

class GameObject < Node

  class Point

    attr_reader :position, :color

    def initialize v, c
      @position = v
      @color = c
    end

  end

  def initialize
    @points = []
    @size = 16
    super
  end


  def add v, c
    @points << Point.new(v, c)
  end

  def compile

    # Compile

    @list = glGenLists 1

    glNewList @list, GL_COMPILE

      glPointSize @size
      glBegin GL_POINTS
        for i in @points
          glColor3f  i.color.r, i.color.g, i.color.b
          glVertex3f i.position.x, i.position.y, i.position.z
        end
      glEnd
    glEndList

    @points = nil

  end

  def render
    glPushMatrix
      glTranslatef @position.x, @position.y, @position.z
      glCallList @list
    glPopMatrix
  end

  def delete
    glDeleteLists @list
  end

end
