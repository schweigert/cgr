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
      #glOrtho 0.0, 800, 600, 0.0, 1, 150
      gluPerspective 60, 800.to_f/600, 0.1, 100.0
      gluLookAt 0,0,-10, 0, 1, 0, 0, 1, 0
    glPopMatrix

  end

end
