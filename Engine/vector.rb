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
