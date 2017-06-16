require 'gl'
require 'glu'
require 'glut'

require_relative "game"
require_relative "clock"

include Gl
include Glu
include Glut

def onIdleEvent
  Clock.update
  $scene.onIdle Clock.deltaTime
  glutPostRedisplay
end

def onRenderEvent

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  glClearColor 0.7, 0.7, 0.7, 0

  $scene.onRender

  glutSwapBuffers
end

glutInit
glutInitDisplayMode GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH
glutInitWindowSize $winX, $winY
$window = glutCreateWindow $name

glutIdleFunc      method(:onIdleEvent).to_proc
glutDisplayFunc   method(:onRenderEvent).to_proc


glEnable GL_DEPTH_TEST


Clock.init
glutMainLoop
