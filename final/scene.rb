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
  end

end
