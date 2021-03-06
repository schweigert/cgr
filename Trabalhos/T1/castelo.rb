#######################################
# Trabalho CGR
# Castelo de Nárnia
# CGR - UDESC
#     Marlon Henry Schweigert
#     Jonathan de Oliveira Cardoso
#######################################

require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut


############
## CAMERA ##
############

$posiCamera = [-10.0, 5.0, -10.0]
$rot = 0

def render_camera
  # Modo Projeção
  glMatrixMode GL_PROJECTION
  # Carregar a matriz identidade
  glLoadIdentity

  # Carregar modo de perspectiva
  gluPerspective $fov, $winX.to_f/$winY.to_f, 0.1, 100.0
  posi = $posiCamera
  foco = [ 0.0,  0.0,  0.0]
  cima = [ 0.0,  1.0,  0.0]

  gluLookAt posi[0],posi[1],posi[2], foco[0], foco[1], foco[2], cima[0], cima[1], cima[2]
end

def render_colum q, x, y

  glPushMatrix
    glRotatef $rot, 0, 1.0, 0

    glColor3f 0.5, 0.32, 0.18
    glPushMatrix
        glTranslatef x, 0, y
        glRotatef 90, 1, 0, 0
        gluCylinder q, 1.0, 1.0, 3.0, 10, 10
    glPopMatrix

    glColor3f 0.5, 0, 0
    glPushMatrix
      glTranslatef x, 0, y
      glRotatef 90, -1, 0, 0
      glutSolidCone 1.5, 1.0, 10, 10
    glPopMatrix
  glPopMatrix

end

def render_base x

  glPushMatrix
    glColor3f 0.5, 0.32, 0.18
    glRotatef $rot, 0, 1.0, 0
    glScalef 1, 2, 1
    glPushMatrix
      glTranslatef x, -1, 0
      glScalef 1, 1, 8
      glutSolidCube 1
    glPopMatrix

    glPushMatrix
      glTranslatef -x, -1, 0
      glScalef 1, 1, 8
      glutSolidCube 1
    glPopMatrix

    glPushMatrix
      glTranslatef 0, -1, x
      glScalef 8, 1, 1
      glutSolidCube 1
    glPopMatrix

    glPushMatrix
      glTranslatef 0, -1, -x
      glScalef 8, 1, 1
      glutSolidCube 1
    glPopMatrix
  glPopMatrix

end


def onStartGL windowX, windowY
  glEnable GL_TEXTURE_2D
  glEnable GL_DEPTH_TEST
  glEnable GL_CULL_FACE

  # Luz
  # glEnable GL_LIGHTING
  # glEnable GL_LIGHT0


  # light0posi = [-3,5,-4,0]
  # glLightfv GL_LIGHT0, GL_POSITION, light0posi
  # glColorMaterial GL_FRONT, GL_AMBIENT_AND_DIFFUSE

  # no_mat = [0.0, 0.0, 0.0, 1.0]
  # mat_ambient = [0.0215,  0.1745,   0.0215,  1.0]
  # mat_diffuse = [0.07568, 0.61424,  0.07568, 1.0]
  # mat_specular = [0.633,   0.727811, 0.633,   1.0]
  # low_shininess = 35.0


  # glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
  # glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);
  # glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
  # glMaterialf(GL_FRONT, GL_SHININESS, low_shininess);
  # glMaterialfv(GL_FRONT, GL_EMISSION, no_mat);

end

def onFinishGL
  glutDestroyWindow $window
  exit 0
end

def onRenderEvent
  # Limpa o Buffer da tela e de perspectiva
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  # Limpar toda a tela
  glClearColor(0.0, 1.0, 0.0, 0)


  # Modo suavizado
  glShadeModel GL_SMOOTH


  ################
  ## NOSSA CENA ##
  ################

  $rot += 1


  # Criar a quadrica
  q = gluNewQuadric

  # Desenhar a cena
  render_camera


  render_base 4
  # Desenhar colunas
  render_colum q,  4,  4
  render_colum q,  4, -4
  render_colum q, -4,  4
  render_colum q, -4, -4
  # Envia buffer da memória RAM para a placa de vídeo
  glutSwapBuffers

  # Deseltar a quadrica
  gluDeleteQuadric q
end

def onReshapeEvent x, y
  x = 1 if x == 0
  y = 1 if y == 0

  # Resetar o atual viewpoint e transformada da perspectiva
  glViewport 0, 0, x, y

  glMatrixMode GL_PROJECTION
  glLoadIdentity

  gluPerspective $fov, x / y, 0.1, 100.0
end

def onKeyboardEvent key, mouseX, mouseY
  case key
  when ?\e
    glutDestroyWindow $window
    exit 0
  when ?a
    $posiCamera[0] += 1.0
  when ?d
    $posiCamera[0] -= 1.0
  when ?w
    $posiCamera[2] += 1.0
  when ?s
    $posiCamera[2] -= 1.0
  when ?z
    $posiCamera[1] += 1.0
  when ?x
    $posiCamera[1] -= 1.0
  end
  puts $posiCamera
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
  glutPostRedisplay
end


##########
## MAIN ##
##########
$time = 0.0
$winX = 640
$winY = 480
$fov = 70

# Inicializar a glut
glutInit
# Inicializar buffers
glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
# Inicializar a janela
glutInitWindowSize($winX, $winY)
# Inicializa  o objeto da janela
$window = glutCreateWindow("Atividade Castelo | Ruby <3")

glutDisplayFunc   method(:onRenderEvent).to_proc
glutReshapeFunc   method(:onReshapeEvent).to_proc
glutKeyboardFunc  method(:onKeyboardEvent).to_proc
glutSpecialFunc   method(:onSpecialKeyboardEvent).to_proc
glutMouseFunc     method(:onMouseButtonEvent).to_proc
glutMotionFunc    method(:onMouseMotionEvent).to_proc
glutIdleFunc      method(:onIdleEvent).to_proc

# Executa a preparação da janela
onStartGL $winX, $winY

# Loop do OpenGL
glutMainLoop()
