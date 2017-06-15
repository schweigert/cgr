#include "colors.inc"
#include "textures.inc"
#include "finish.inc"
#include "glass.inc"

camera {
 location <0, 2, -5>
 look_at <0, 1, 2>
}

// Cor de fundo. Nao é objeto de cena.
background { color Black }

// Fonte de Luz Branca posicionada
// em x=20, y=4 e z=-13
light_source { <20, 4, -13> color White}


// Plano com textura em xadrez para chão
plane { <0, 1, 0>, -1
 pigment {
 checker color Red, color Blue
 }
}

intersection {
 sphere { <0, 0, 0>, 1
 translate -0.5*x
 }
 sphere { <0, 0, 0>, 1
 translate 0.5*x
 }
 pigment { Red }
 rotate -30*y // para visualizar disco “de lado”
 finish { Shiny }
}

sphere {
 <15, 1, 30>, 2
 texture {
 pigment {Red}
 finish { M_Glass }
 }
}

fog {
 distance 20
 color rgbt <0.7 0.7 0.7 0.5>
}
