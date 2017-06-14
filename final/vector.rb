class Vector

  # Acesso ao parâmetro x
  def x; return @x; end
  # Acesso ao parâmetro y
  def y; return @y; end

  # Cria um novo Vetor no R²
  def initialize px=0,py=0
    @x = px
    @y = py
  end

  # Retorna o comprimento do vetor
  def size
    return (@x**2 + @y**2)**(0.5)
  end

  # Retorna um vetor com mesmo sentido, mas tamanho 1
  def normalize
    s = self.size
    return Vector.new @x/size, @y/size
  end

  # Aplica a normalização no próprio objeto
  def normalize!
    s = self.size
    @x /= s
    @y /= s
  end

  # Retorna um vetor com um comprimento dependente de K
  def resize k
    return Vector3.new @x*k, @y*k
  end

  # Aplica a multiplicação a este próprio vetor
  def resize! k
    @x *= k
    @y *= k
  end

  # Sobrecarrega a operação de soma
  def + v
    return Vector.new @x + v.x, @y + v.y
  end

  def * v
    return Vector.new @x * v, @x * v unless v.class == Vector
    return Vector.new 
  end

end
