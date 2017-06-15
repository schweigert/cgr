class Vector2D

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
    return Vector2D.new @x/size, @y/size
  end

  # Aplica a normalização no próprio objeto
  def normalize!
    s = self.size
    @x /= s
    @y /= s
  end

  # Retorna um vetor com um comprimento dependente de K
  def resize k
    return Vector2D.new @x*k, @y*k
  end

  # Aplica a multiplicação a este próprio vetor
  def resize! k
    @x *= k
    @y *= k
  end

  # Sobrecarrega a operação de soma
  def + v
    return Vector2D.new @x + v.x, @y + v.y
  end

  # Sobrecarrega a operação de multiplicação
  def * v
    return Vector2D.new @x * v, @x * v
  end


end

Vector2D::Unit  =  Vector2D.new  1, 1
Vector2D::Up    =  Vector2D.new  1, 0
Vector2D::Down  =  Vector2D.new -1, 0
Vector2D::Right =  Vector2D.new  0, 1
Vector2D::Left  =  Vector2D.new  0,-1
