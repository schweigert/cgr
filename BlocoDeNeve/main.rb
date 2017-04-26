# Atividade Boneco de Neve
# Marlon Henry
# CGR - 2017.1
#  UDESC - CCT

require "gl"
require "glu"
require "glut"

include Gl
include Glu
include Glut

window = ""

def init_gl_window(width = 640, height = 480)
    # Desenhar fundo
    glClearColor(0.0, 0.0, 0.0, 0)
    # Ativar limpeza do Buffer de Teste de profundidade
    glClearDepth(1.0)
    # Especificar qual o tipo de teste de profundidade
    glDepthFunc(GL_LEQUAL)
    # Ativar teste de profundidade
    glEnable(GL_DEPTH_TEST)
    # Ativar normalização suavizada
    glShadeModel(GL_SMOOTH)

	 
	 # Configurar câmera
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    # Calculate aspect ratio of the window
    gluPerspective(45.0, width / height, 0.1, 100.0)

    glMatrixMode(GL_MODELVIEW)

    draw_gl_scene
end

#reshape = Proc.new do |width, height|
def reshape(width, height)
    height = 1 if height == 0

    # Reset current viewpoint and perspective transformation
    glViewport(0, 0, width, height)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity

    gluPerspective(45.0, width / height, 0.1, 100.0)
end

#draw_gl_scene = Proc.new do
def draw_gl_scene
    # Clear the screen and depth buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

    # Reset the view
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity

    # Move left 1.5 units and into the screen 6.0 units
    glTranslatef(-1.5, 0.0, -6.0)

    # Draw a triangle
    glBegin(GL_POLYGON)
        glVertex3f( 0.0,  1.0, 0.0)
        glVertex3f( 1.0, -1.0, 0.0)
        glVertex3f(-1.0, -1.0, 0.0)
    glEnd

    # Move right 3 units
    glTranslatef(3.0, 0.0, 0.0)

    # Draw a rectangle
    glBegin(GL_QUADS)
        glVertex3f(-1.0,  1.0, 0.0)
        glVertex3f( 1.0,  1.0, 0.0)
        glVertex3f( 1.0, -1.0, 0.0)
        glVertex3f(-1.0, -1.0, 0.0)
    glEnd

    # Swap buffers for display 
    glutSwapBuffers
end

# The idle function to handle 
def idle
    glutPostRedisplay
end

# Keyboard handler to exit when ESC is typed
keyboard = lambda do |key, x, y|
    case(key)
      when ?\e
          glutDestroyWindow(window)
          exit(0)
      end
      glutPostRedisplay
end


# Initliaze our GLUT code
glutInit;
# Setup a double buffer, RGBA color, alpha components and depth buffer
glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH);
glutInitWindowSize(640, 480);
glutInitWindowPosition(0, 0);
window = glutCreateWindow("NeHe Lesson 02 - ruby-opengl version");
glutDisplayFunc(method(:draw_gl_scene).to_proc);
glutReshapeFunc(method(:reshape).to_proc);
glutIdleFunc(method(:idle).to_proc);
glutKeyboardFunc(keyboard);
init_gl_window(640, 480)
glutMainLoop();
