require_relative "camera"
require_relative "entity"

class Scene

  def initialize
    @entitiesList = []
    createScene
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
    for i in @entitiesList
      i.onRender
    end
  end

  def createScene
    obj = Camera.new
    attach obj

    obj = Entity.new
    attach obj

    obj = Fire.new 3000, 3
    attach obj
  end

end
