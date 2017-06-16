require 'gl'
require 'glu'
require 'glut'
require 'gosu'

include Gl
include Glu
include Glut

class Vector

  attr_accessor :x, :y, :z, :w

  def initialize x=0.0, y=0.0, z=0.0, w=0.0
    @x = x
    @y = y
    @z = z
    @w = w
  end

  def norma
    return (x**2 + y**2 + z**2 + w**2)**(0.5)
  end

  def normal
    return self*(1.0/norma)
  end

  def + v
    return Vector.new @x + v.x, @y + v.y, @z + v.z, @w + v.w
  end

  def * v
    return Vector.new @x * v, @y * v, @z * v, @w * v
  end

end


class Clock

  def self.init
    @@last = Time.now
    @@deltaTime = 0
  end

  def self.update
    @@deltaTime = Time.now - @@last
    @@last = Time.now
  end

  def self.deltaTime; return @@deltaTime; end

end

class Texture
  attr_reader :image, :info, :id
  def initialize filename
    @image = Gosu::Image.new $win, filename, :tileable => true
    @info = @image.gl_tex_info
    @id = @info.tex_name
  end
end

class Node2D
  def initialize x = 0,y = 0
    @position = Vector.new x, y
    @nodes = []
  end

  def << obj
    @nodes << obj
  end

  def draw
    glPushMatrix
    glTranslatef @position.x, @position.y, 0
    for i in @nodes
      i.draw
    end
    glPopMatrix
  end

  def update delta
    for i in @nodes
      i.update delta
    end
  end
end

class Sprite < Node2D
  def initialize filename
    super
    @tex = Texture.new filename
  end

  def draw
    glMatrixMode GL_MODELVIEW
    glBindTexture GL_TEXTURE_2D,@tex.id
    glPushMatrix
      glBegin GL_QUADS
        glTexCoord2f(@tex.info.left, @tex.info.bottom); glVertex3f    0,   0,  0
        glTexCoord2f(@tex.info.right, @tex.info.bottom); glVertex3f  -1,   0,  0
        glTexCoord2f(@tex.info.right, @tex.info.top); glVertex3f  -1, 1,  0
        glTexCoord2f(@tex.info.left, @tex.info.top); glVertex3f    0, 1,  0
      glEnd
    glPopMatrix
  end
end


class Engine < Gosu::Window
  def initialize
    super 640, 480
    @title = "CGR Engine"
    self.caption = @title + " [60]"
    init
    scene
  end

  def init
    $win = self
    glEnable GL_DEPTH_TEST
    glEnable GL_TEXTURE_2D

    Clock.init
  end

  def scene
    @scene = Node2D.new

    spriteNode = Node2D.new 1,1
    spriteNode << Sprite.new("sprites/char001/down0.png")
    @scene << spriteNode

    spriteNode = Node2D.new 3,3
    spriteNode << Sprite.new("sprites/char001/down0.png")
    @scene << spriteNode

    spriteNode = Node2D.new -3,5
    spriteNode << Sprite.new("sprites/char001/down1.png")
    @scene << spriteNode
  end

  def update
    Clock.update
    delta = Clock.deltaTime
    @scene.update delta

    ## Update Title (1 in 1 secs)
    $sec ||= 0
    $sec += delta

    if $sec > 1
      self.caption = @title + " [#{(1/delta).to_i}]"
      $sec -= 1
    end
  end

  def draw
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT) #see lesson 01

    glMatrixMode(GL_PROJECTION) #see lesson01
    glLoadIdentity # see lesson01

    glOrtho -8, 8, -8, 8, -100, 100
    gluLookAt 0,0,-10,0,0,0,0,1,0
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST) #Perspective correction calculation for most correct/highest quality value
    glMatrixMode(GL_MODELVIEW)  #see lesson 01



    @scene.draw
  end

  def button_down(id)
   if id == Gosu::KbEscape
     close
   end
 end

end

Engine.new.show
