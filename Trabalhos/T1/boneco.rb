#######################################
# Trabalho CGR
# Boneco de Neve
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

$posiCamera = [0.0, 0.0, 5.0]
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

def render_sphere r, x, y, z
    glPushMatrix
      glTranslatef x, y, z
      glutSolidSphere r, 20, 20
    glPopMatrix
end

def render_cone r, s, x, y, z
    glPushMatrix
      glTranslatef x, y, z
      glRotatef -90, 0.0, 1.0, 0.0
      glutSolidCone r, s, 20, 20
    glPopMatrix
end


def onStartGL windowX, windowY
  glEnable GL_TEXTURE_2D
  glEnable GL_DEPTH_TEST
  glEnable GL_CULL_FACE
  #glEnable GL_LIGHTING
end

def onFinishGL
  glutDestroyWindow $window
  exit 0
end

def onRenderEvent
  # Limpa o Buffer da tela e de perspectiva
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  # Limpar toda a tela
  glClearColor(0.0, 0.0, 0.0, 0)


  # Modo suavizado
  glShadeModel GL_SMOOTH


  ################
  ## NOSSA CENA ##
  ################

  # Desenhar a cena
  render_camera

  $rot += 1

  glRotatef $rot, 0.0, 1.0, 0.0

  glColor3f 1.0, 1.0, 1.0
  # Desenhar o corpo
  render_sphere 1.0, 0.0, 0.0, 0.0
  # Desenhar a Cabeça
  render_sphere 0.75, 0.0, 1.5, 0.0
  # Desenhar Olhos
  glColor3f 0.0, 0.0, 0.0
  render_sphere 0.15, -0.6, 1.6, 0.2
  render_sphere 0.15, -0.6, 1.6, -0.2

  # Desenhar Nariz
  glColor3f 1.0, 0.65, 0.0
  render_cone 0.1, 0.5, -0.7, 1.5, 0.0

  # Bracinhos (Tudo com bracinhos fica melhor)

  glLineWidth 10
  glColor3f 0.36, 0.25, 0.2
  glBegin GL_LINES
    glVertex3f 0.0, 0.4, 0.0
    glVertex3f -0.4, 0.8, 1.6
  glEnd

  glBegin GL_LINES
    glVertex3f 0.0, 0.4, 0.0
    glVertex3f -0.4, 0.8, -1.6
  glEnd

  # Envia buffer da memória RAM para a placa de vídeo
  glutSwapBuffers

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
$window = glutCreateWindow("Atividade Boneco de Neve | Ruby <3")

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
