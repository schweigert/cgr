require_relative 'vector'

require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

class Entity

	def initialize
		@position = Vector.new
		@entitiesList = []
	end

	def translate v
		@position = v
	end

	def translate! v
		@position += v
	end

	def attach entity
		@entitiesList << entity
	end

	def onLoop deltaTime
		for i in @entitiesList
			i.onLoop deltaTime
		end
	end

	def onRender
		glPushMatrix
			glTranslatef @position.x, @position.y, 0
			glBegin GL_POINTS
				glVertex3f 0, 0, 0
			glEnd
			for i in @entitiesList
				i.onRender
			end
		glPopMatrix
	end

end
