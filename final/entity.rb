require_relative 'vector'

require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut


class Fire

  def initialize maxParticles = 5000, maxTime = 2.0
    @maxParticles = maxParticles
    @maxTime = maxTime
    @posi = [0,0,0]
    @particles = []

    @windTime = 0
    @windForce = [-3,0,-0.3]

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
        glVertex3f(posi[0], posi[1], posi[2])
      end
      glEnd();

      glEnable GL_LIGHTING

    glPopMatrix
  end

end

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
		puts "Render points"
		glPushMatrix
			glPointSize 8
			glTranslatef @position.x, @position.y, 0
			glBegin GL_POINTS
				glVertex3f 0, 0, 0
				glVertex3f 1, 0, 0
				glVertex3f 0, 1, 0
				glVertex3f 0, 0, 1
			glEnd
			for i in @entitiesList
				i.onRender
			end
		glPopMatrix
	end

end
