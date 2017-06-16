require 'gl'
require 'glu'
require 'glut'
require 'rmagick'

include Gl
include Glu
include Glut
include Magick

class Sprite

  def initialize filename
    @tex = glGenTextures 1
    image = Image.read(filename).first
    glBindTexture GL_TEXTURE_2D, @tex[0]
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST
    glTexImage2D GL_TEXTURE_2D, 0, GL_RGB, image.columns, image.rows, 0,GL_RGB, GL_UNSIGNED_BYTE,
                image.export_pixels_to_str(0, 0, image.columns, image.rows, 'RGB', CharPixel)

  end

  def draw
    glEnable GL_TEXTURE_2D
    glBindTexture GL_TEXTURE_2D, @tex[0]
    glBegin GL_QUADS
      glNormal3f 0, 0, 1
      glTexCoord2fv 0, 1; glVertex3f -1, -1, 0
      glTexCoord2fv 1, 1; glVertex3f 1, -1, 0
      glTexCoord2fv 1, 0; glVertex3f 1, 1, 0
      glTexCoord2fv 0, 0; glVertex3f -1, 1, 0
    glEnd
    glDisable GL_TEXTURE_2D
  end

end
