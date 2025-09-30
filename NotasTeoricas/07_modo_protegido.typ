#align(center)[= Sistemas operativos]

== Objetivos

- Proveer recursos a las apps
- Administrar recursos


== Problemas

- Memoria insuficiente
- *Fragmentacion de memoria*: Ocurre cuando tenes que guardar elementos de 
  varios tipos de tamaños -> tenes "lugarcitos" libres que tenes que aprovechar
  estrategicamente para reducir esa cantidad de "lugarcitos"
- Seguridad


== Como?

- Abstraccion (mostrar un ambiente no fisico)
- Interposicion (interceptar acciones)

#align(center)[=== El microprocesador nos da soluciones a estos problemas]

#align(center)[= Modo protegido]

= Modo protegido - MMU

- Metodo de interposicion
  - Cada acceso a memoria, checkea si esta bien o esta mal

#align(center)[Direcciones logicas]

#line(length: 100%)
#align(center)[*Unidad de segmentacion*]
#line(length: 100%)

#align(center)[Direccion Lineal]

#line(length: 100%)
#align(center)[*Unidad de paginacion*]
#line(length: 100%)

#align(center)[Direccion fisica]

#line(length: 100%)
#align(center)[*Memoria fisica*]
#line(length: 100%)

= Memoria virtual

- El procesador siempre nos da memoria

- Nunca te dice que no tenes mas

- Abstraccion sobre la memoria fisica

- No accedes a la memoria fisica en realidad

- Te dicen 2000h pero es virtual, en realidad es probable que estes
  accediendo fisicamente a otro lado



