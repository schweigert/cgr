class Color < Vector

  def initialize r,g,b
    super(r/255.0,g/255.0,b/255.0)
  end

  def r; return x; end
  def g; return y; end
  def b; return z; end

end
