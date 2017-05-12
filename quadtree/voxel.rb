######################################
# ALGORITMO DE QUADTREE
# Modo de representar um objeto dizendo se ele está
# preenchido ou não em determinado quadrante.
#
# Implementado por:
# => Marlon Henry Schweigert © 2017
#
######################################

:full     # Quadrante cheio
:empty    # Quadrante vazio
:partial  # Parcial


# Classe que representa os quadrantes em modo árvore
#
#       |
#   0   |   3
#       |
# ------x------
#       |
#   1   |   2
#       |
class Quadtree

  @quad_0
  @quad_1
  @quad_2
  @quad_3

  @status

  # Status:
  # :full, :empty, partial
  def initialize status, *quads
    @status = status
    if @status == :partial
      @quad_0 = quads[0]
      @quad_1 = quads[1]
      @quad_2 = quads[2]
      @quad_3 = quads[3]
    end
  end

  

end
