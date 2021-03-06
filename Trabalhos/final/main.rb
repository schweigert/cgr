require 'gl'
require 'glu'
require 'glut'

require_relative "timer"
require_relative "entity"
require_relative "scene"

include Gl
include Glu
include Glut

def onFinishGL
  glutDestroyWindow $window
  exit 0
end

def onRenderEvent

  glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
  glClearColor 1,1,1,0


  $scene.onRender

  glutSwapBuffers

end

def onReshapeEvent x, y

  x = 1 if x == 0
  y = 1 if y == 0

  glViewport 0, 0, x, y

  glMatrixMode GL_PROJECTION
  glLoadIdentity


end

def onKeyboardEvent key, mouseX, mouseY

  case key
  when ?\e
    glutDestroyWindow $window
    exit 0
  end

  glutPostRedisplay
end

def onSpecialKeyboardEvent key, mouseX, mouseY
  glutPostRedisplay
end

def onMouseButtonEvent button, state, mouseX, mouseY
  glutPostRedisplay
end

def onMouseMotionEvent mouseX, mouseY
  glutPostRedisplay
end

def onIdleEvent

  $timeAcc ||= 0

  Timer.update
  $timeAcc += Timer.deltaTime

  $scene.onLoop Timer.deltaTime

  if $timeAcc > 1
    glutSetWindowTitle "CGREngine [#{(1/Timer.deltaTime).to_i}]"
    $timeAcc -= 1
  end

  glutPostRedisplay
end

glutInit
glutInitDisplayMode GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH
glutInitWindowSize 800, 600
$window = glutCreateWindow "CGREngine [60]"

glutDisplayFunc   method(:onRenderEvent).to_proc
glutReshapeFunc   method(:onReshapeEvent).to_proc
glutKeyboardFunc  method(:onKeyboardEvent).to_proc
glutSpecialFunc   method(:onSpecialKeyboardEvent).to_proc
glutMouseFunc     method(:onMouseButtonEvent).to_proc
glutMotionFunc    method(:onMouseMotionEvent).to_proc
glutIdleFunc      method(:onIdleEvent).to_proc

glEnable GL_TEXTURE_2D
glEnable GL_DEPTH_TEST
glEnable GL_CULL_FACE
glEnable GL_COLOR_MATERIAL

$scene = Scene.new

Timer.init

glutMainLoop()
