require_relative 'vector'

class Entity

	def initialize
		@position = Vector.new
	end

	def translate v
		@position = v
	end

	def translate! v
		@position += v
	end

	def onLoop deltaTime
	end

	def onRender
	end

end
