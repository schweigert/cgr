class Vector < Array

  def initialize x=0,y=0,z=0
    super(3,0)
    self[0] = x
    self[1] = y
    self[2] = z
  end

  def x
    return self[0]
  end

  def y
    return self[1]
  end

  def z
    return self[2]
  end


  def + v
    return Vector.new x + v.x, y + v.y, z+v.z
  end

  def !
    s = size
    return Vector.new(@x/size, @y/size, @z/size)
  end

  def size
    return (@x**2 + @y**2 + @z**2)**0.5
  end

  def * f
    return Vector.new x*f, y*f, z*f
  end


end
