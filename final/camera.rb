require_relative "entity"

require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

class Camera < Entity

  def onRender

    glPushMatrix
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      glOrtho 0.0, 800, 600, 0.0, 1, 150
      #gluLookAt @position.x,@position.y,-10, @position.x, @position.y, 0, 0, 1, 0
    glPopMatrix

  end

end
