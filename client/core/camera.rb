require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

require_relative "node"

class Camera < Node

  def initialize
    super
    @focalPoint = Vector.new
    @upVector   = Vector.new(0,1,0)
    @nearPlane = 0.1
    @farPlane =  150.0
    @fov = 70
  end

  def lookAt v
    @focalPoint = v
  end

  def lookFromAngle ro, theta, phi
    @focalPoint = @position + Vector.fromSpherical(ro, theta, phi)
  end

  def render
    glPushMatrix
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      gluPerspective @fov, $winX.to_f/$winY.to_f, @nearPlane, @farPlane
      gluLookAt @position.x, @position.y, @position.z,
                @focalPoint.x, @focalPoint.y, @focalPoint.z,
                @upVector.x, @upVector.y, @upVector.z
      glMatrixMode GL_MODELVIEW
    glPopMatrix
  end

end
