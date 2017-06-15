require_relative "vector2d"

class Entity

  def initialize
    @position = Vector2D.new 0,0
  end

  def onLoop deltaTime
  end

  def onRender
    glPushMatrix
      glTranslatef @position.x, @position.y, 0

      glBegin GL_POINTS

        glColor3f 0,0,0
        glVertex2f 0,0

      glEnd

    glPopMatrix
  end

end
