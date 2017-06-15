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

  end

end
