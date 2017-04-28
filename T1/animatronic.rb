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

########################################
#
#  Gerando uma árvore para a cena
#   -> Entity terá um sistema de transformação
#   -> A função draw ficará em branca para desenho
#
########################################

class Entity

  def initialize
    @rot = [0,0,0]
    @pos = [0,0,0]
    @scl = [1,1,1]
    @cor = [0,0,0]
    @attachList = []
  end

  def setRotation x, y, z
    @rot = [x, y, z]
  end

  def setTranslate x, y, z
    @pos = [x, y, z]
  end

  def setScale x, y, z
    @scl = [x, y, z]
  end

  def setColor r, g, b
    @cor = [r,g,b]
  end

  def attach obj
    @attachList << obj
  end

  def draw
    # Está vazio, pois é um pivot
  end

  def onLoop
    glPushMatrix
      glColor3f @cor[0],@cor[1],@cor[2]
      glTranslatef @pos[0], @pos[1], @pos[2]
      glRotatef    @rot[0], 1, 0, 0
      glRotatef    @rot[1], 0, 1, 0
      glRotatef    @rot[2], 0, 0, 1


      for i in @attachList
        i.onLoop
      end

      glScalef     @scl[0], @scl[1], @scl[2]
      draw
    glPopMatrix
  end

end

class CubeEntity < Entity

  def draw
    glutSolidCube 1
  end

end

############
## CAMERA ##
############

$posiCamera = [-10.0, 5.0, -10.0]

$scene = Entity.new

# Character

charPivot = Entity.new
$scene.attach charPivot

# Body
body = CubeEntity.new
body.setScale 1, 2, 1
charPivot.attach body

# Legs 1

leg1Pivot = Entity.new
leg1Pivot.setTranslate 0.5, -1, 0

leg1 = CubeEntity.new
leg1.setTranslate 0, -1, 0
leg1.setScale 0.5, 2, 0.5

leg1Pivot.attach leg1

body.attach leg1Pivot

# Legs 2

leg2Pivot = Entity.new
leg2Pivot.setTranslate -0.5, -1, 0

leg2 = CubeEntity.new
leg2.setTranslate 0, -1, 0
leg2.setScale 0.5, 2, 0.5

leg2Pivot.attach leg2

body.attach leg2Pivot


# Arm 1

arm1Pivot = Entity.new
arm1Pivot.setTranslate 0.4 , 0.4, 0

arm1 = CubeEntity.new
arm1.setTranslate 2, 0, 0
arm1.setScale 2.5, 0.5, 0.5
arm1Pivot.attach arm1

body.attach arm1Pivot

# Arm 2

arm2Pivot = Entity.new
arm2Pivot.setTranslate -0.4 , 0.4, 0

arm2 = CubeEntity.new
arm2.setTranslate -2, 0, 0
arm2.setScale 2.5, 0.5, 0.5
arm2Pivot.attach arm2

body.attach arm2Pivot



# Head

headPivot = Entity.new
headPivot.setTranslate 0, 1, 0

headmesh = CubeEntity.new
headmesh.setTranslate 0, 1, 0
headmesh.setScale 1.75, 1.75, 1.75
headPivot.attach headmesh


body.attach headPivot

# Pose
leg1Pivot.setRotation -30,0, 0
leg2Pivot.setRotation 30,0, 0
arm1Pivot.setRotation 30, 30, 30
arm2Pivot.setRotation 0, 0, 30
headPivot.setRotation 0, 30, 30

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



def onRenderEvent
  # Limpa o Buffer da tela e de perspectiva
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  # Limpar toda a tela
  glClearColor(0.7, 0.7, 0.9, 0)

  # Modo suavizado
  glShadeModel GL_SMOOTH

  # Posicionar a camera
  render_camera

  # Renderizar cena
  $scene.onLoop

  # Envia buffer da memória RAM para a placa de vídeo
  glutSwapBuffers


end

def onStartGL windowX, windowY
  glEnable GL_TEXTURE_2D
  glEnable GL_DEPTH_TEST
  glEnable GL_CULL_FACE

  # Luz
  glEnable GL_LIGHTING
  glEnable GL_LIGHT0


  light0posi = [-3,5,-4,0]
  glLightfv GL_LIGHT0, GL_POSITION, light0posi
  glColorMaterial GL_FRONT, GL_AMBIENT_AND_DIFFUSE

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
$window = glutCreateWindow("Atividade Bruneco Animado | Ruby <3")

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
