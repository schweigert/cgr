require 'gl'
require 'glu'
require 'sdl'
require 'gosu'

include Gl
include Glu
include Glut
include Gosu

class Sprite

  def initialize filename
    gosu_image = Gosu::Image.new filename
    array_of_pixels = gosu_image.to_blob
    @texture_id = glGenTextures 1
    glBindTexture(GL_TEXTURE_2D, @texture_id[0])
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, gosu_image.width, gosu_image.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, array_of_pixels)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
    gosu_image = nil
  end

  def id; return @texture_id[0]; end

end
