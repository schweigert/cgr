######################################
# Criado por Marlon Henry Schweigert #
# © 2017                             #
######################################

require 'gl'
require 'glu'
require 'glut'

require_relative "entity"

include Gl
include Glu
include Glut


############
## CAMERA ##
############

$posiCamera = [5.0, 0.0, 10.0]
$rot = 0

$title = "Atividade de Particulas | Ruby <3"

class Fire

  def initialize maxParticles = 5000, maxTime = 2.0
    @maxParticles = maxParticles
    @maxTime = maxTime
    @posi = [0,0,0]
    @particles = []

    @windTime = 0
    @windForce = [3,0,0]

    @maxParticles.times do
      # [ [pos x, pos y, pos z], lifetime, velocity x, velocity z , color]
      @particles << [[rand,rand,rand],rand*maxTime,(rand*2 -1)/2, (rand*2 -1)/2, rand/10*2 + 0.8]
    end
  end

  def setTranslate x,y,z
    @posi = [x,y,z]
  end


  def onLoop deltaTime

    @windTime += deltaTime

    for i in 0..(@particles.size-1)
      posi, time, velo_x, velo_z, color = @particles[i]
      if time > @maxTime + rand*3

        @particles[i] = [[rand, 0, rand], 0, (rand*2 -1)/2, (rand*2 -1)/2, rand/10*2 + 0.8]
        next
      end

      posi[0] = posi[0] + velo_x*deltaTime
      posi[1] = posi[1] + deltaTime
      posi[2] = posi[2] + velo_x*deltaTime

      time = time + deltaTime

      windForceFactor = (Math::sin(@windTime)*deltaTime).abs

      @particles[i] = [posi, time, velo_x + @windForce[0]*windForceFactor, velo_z + @windForce[2]*windForceFactor, color]
    end

  end

  def onRender
    glPushMatrix
      glTranslatef @posi[0], @posi[1], @posi[2]

      glDisable GL_LIGHTING
      glPointSize(8);
      glBegin(GL_POINTS);
      for i in @particles
        posi, time, velo_x, velo_z,color = i
        glColor3f 1, time/@maxTime,time/@maxTime
        glVertex2f(posi[0], posi[1])
      end
      glEnd();

      glEnable GL_LIGHTING

    glPopMatrix
  end

end

def render_camera
  # Modo Projeção
  glMatrixMode GL_PROJECTION
  # Carregar a matriz identidade
  glLoadIdentity

  # Carregar modo de perspectiva
  #gluPerspective $fov, $winX.to_f/$winY.to_f, 0.1, 100.0

  posi = $posiCamera
  foco = [ 0.0,  1.0,  0.0]
  cima = [ 0.0,  1.0,  0.0]

  glOrtho -10 + posi[0], 10 + posi[0], -10 + posi[1], 10 + posi[1],  0.1, 150
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

  glutFullScreen

  glEnable GL_TEXTURE_2D
  glEnable GL_DEPTH_TEST
  glEnable GL_CULL_FACE
  glEnable GL_LIGHTING
  glEnable GL_COLOR_MATERIAL
  # Luz
  glEnable GL_LIGHT0


  light0posi = [-3,5,-4,0]
  glLightfv GL_LIGHT0, GL_POSITION, light0posi
  glColorMaterial GL_FRONT, GL_AMBIENT_AND_DIFFUSE

  no_mat = [0.0, 0.0, 0.0, 1.0]
  mat_ambient = [0.1,  0.1,   0.1,  1.0]
  mat_diffuse = [1, 1,  1, 1.0]
  mat_specular = [0.633,   0.727811, 0.633,   1.0]
  low_shininess = 35.0


  glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
  glMaterialf(GL_FRONT, GL_SHININESS, low_shininess);
  glMaterialfv(GL_FRONT, GL_EMISSION, no_mat);


  # Fogo

  $fire = Fire.new 3000, 3
  $fire1 = Fire.new 10000

  $fire.setTranslate -2,0,0
  $fire1.setTranslate 2,0,0

  $entities = []

  obj = Entity.new
  $entities << obj
end

def onFinishGL
  glutDestroyWindow $window
  exit 0
end

def onRenderEvent
  # Limpa o Buffer da tela e de perspectiva
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  # Limpar toda a tela
  glClearColor(1,1,1, 0)


  # Modo suavizado
  glShadeModel GL_SMOOTH


  #$rot += 1

  ################
  ## NOSSA CENA ##
  ################

  # Desenhar a cena
  render_camera

  #$rot += 1

  glRotatef $rot, 0.0, 1.0, 0.0

  for i in $entities
    i.onRender
  end

  $fire.onRender
  $fire1.onRender



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

$timeControl = 0

def onIdleEvent

  deltaTime = Time.now - $time
  $time = Time.now
  $timeControl += deltaTime
  $fire.onLoop deltaTime
  $fire1.onLoop deltaTime
  if $timeControl > 5
    glutSetWindowTitle $title+" | FPS #{(1/deltaTime).to_i}"
    $timeControl = 0
  end

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
$window = glutCreateWindow($title)

glutDisplayFunc   method(:onRenderEvent).to_proc
glutReshapeFunc   method(:onReshapeEvent).to_proc
glutKeyboardFunc  method(:onKeyboardEvent).to_proc
glutSpecialFunc   method(:onSpecialKeyboardEvent).to_proc
glutMouseFunc     method(:onMouseButtonEvent).to_proc
glutMotionFunc    method(:onMouseMotionEvent).to_proc
glutIdleFunc      method(:onIdleEvent).to_proc

# Executa a preparação da janela
onStartGL $winX, $winY

$time = Time.now

# Loop do OpenGL
glutMainLoop()
