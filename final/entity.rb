require_relative 'vector'

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
	end

	def onRender
	end

end
