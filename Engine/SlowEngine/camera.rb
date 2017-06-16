require_relative "node2d"

class Camera < Node2D

  def onRender

    glMatrixMode GL_PROJECTION
    glLoadIdentity

    glOrtho -$winX/100, $winX/100, -$winY/100, $winY/100, 0.1, 150
    glMatrixMode GL_MODELVIEW

    gluLookAt 0,0,-10,0,0,0,0,1,0

  end

  def draw

  end

end
