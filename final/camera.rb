require_relative "entity"

require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

class Camera < Entity

  def onRender

    puts "Render Camera"

    glPushMatrix
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      glOrtho -10, 10, -10, 10, 1, 150
      gluLookAt @position.x,@position.y,-10, 0, 0, 0, 0, 1, 0
    glPopMatrix

  end

end
