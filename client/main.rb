require 'gl'
require 'glu'
require 'glut'

require_relative "core/scene"
require_relative "app/scenes/testscene"
include Gl
include Glu
include Glut


def onStartEvent

	glEnable GL_DEPTH_TEST

	$scene = TestScene.new
end

def onIdleEvent
	glutPostRedisplay
end

def onRenderEvent
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
	glClearColor 0,0,0,0

	$scene.render

  glShadeModel GL_SMOOTH

	glutSwapBuffers
end

def onReshapeEvent x, y
	puts "reshape: #{x},#{y}"
	glutPostRedisplay
end

def onKeyboardEvent key, mouseX, mouseY
	puts "key: #{key}"
	glutPostRedisplay
end

def onUpKeyboardEvent key, mouseX, mouseY
	puts "key up: #{key}"
	glutPostRedisplay
end

def onSpecialKeyboardEvent key, mouseX, mouseY
	puts "special key: #{key}"
	glutPostRedisplay
end

def onMouseButtonEvent button, state, mouseX, mouseY
	puts "mouse: #{button}, #{state}"
	glutPostRedisplay
end

def onMouseMotionEvent x, y
	puts "position: #{x},#{y}"
	glutPostRedisplay
end

def onMousePassiveMotionEvent x, y
	puts "passive position: #{x}, #{y}"
	glutPostRedisplay
end

# Glut startup

glutInit
glutInitDisplayMode GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH
$winX, $winY = 1280*0.8, 720*0.8
glutInitWindowSize $winX, $winY
$win = glutCreateWindow "Voxel Aventura"

glutDisplayFunc   			method(:onRenderEvent).to_proc
glutReshapeFunc   			method(:onReshapeEvent).to_proc
glutKeyboardFunc  			method(:onKeyboardEvent).to_proc
glutKeyboardUpFunc 			method(:onUpKeyboardEvent).to_proc
glutSpecialFunc   			method(:onSpecialKeyboardEvent).to_proc
glutMouseFunc     			method(:onMouseButtonEvent).to_proc
glutMotionFunc    			method(:onMouseMotionEvent).to_proc
glutPassiveMotionFunc 	method(:onMousePassiveMotionEvent).to_proc
glutIdleFunc      			method(:onIdleEvent).to_proc

#glutFullScreen

onStartEvent


glutMainLoop
