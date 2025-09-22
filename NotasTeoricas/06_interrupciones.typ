= Comunicacion basica con dispositivos

*Polling (sondeo)*: _Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?...Tenes un dato?..._


*Interrupciones*: _Cuando tengas un dato me avisas_

\

= Interrupciones

#let violeta = rgb("#9aa0ff")
#let violeta-borde = rgb("#6a6fd6")
#let rojo = rgb("#e51c20")
#let azul = rgb("#061a3b")
#let verde = rgb("#1ea75b")

#align(center)[
  #text(size: 36pt, weight: 700, fill: violeta-borde)[Programa Principal]
]

#v(18pt)

// Dibujamos la barra principal
#box(
  width: 100%, height: 170pt,
  fill: violeta, stroke: 1pt + violeta-borde, radius: 4pt,
  inset: 0pt
)[
  // Interrupciones colocadas encima
  #place(dx: 20%, dy: 0pt)[
    #rect(width: 8%, height: 170pt, fill: rojo)
  ]
  #place(dx: 52%, dy: 0pt)[
    #rect(width: 6%, height: 170pt, fill: azul)
  ]
  #place(dx: 80%, dy: 0pt)[
    #rect(width: 7%, height: 170pt, fill: verde)
  ]
]

#v(18pt)

// Rótulos
#grid(
  columns: 3,
  gutter: 48pt,
  align(center)[
    #text(size: 19pt, weight: 700, fill: rojo)[Interrupción]
    #linebreak()
    #text(size: 19pt, weight: 700, fill: rojo)[de teclado]
  ],
  [
    #text(size: 19pt, weight: 700, fill: azul)[Interrupción]
    #linebreak()
    #text(size: 19pt, weight: 700, fill: azul)[de Mouse]
  ],
  [
    #text(size: 19pt, weight: 700, fill: verde)[Interrupción]
    #linebreak()
    #text(size: 19pt, weight: 700, fill: verde)[X]
  ],
)

- Importante saber que solo se corre un programa a la vez

- La computadora le asigna cierto tiempo a cada aplicacion

== Como funciona el teclado?

- Se presiona una tecla

- Se interrumpe el programa que esta corriendo actualmente

- El driver de teclado interpreta esa tecla que se presiono

- Se deja en un buffer los bytes que representan cierta letra


#align(center)[= Interrupciones de Software]
Se interrumple la ejecucion del programa al ejecutar la instruccion de assembler INT. Por ejemplo INT 44h (donde 44h es el numero de rutina de interrupcion a ejecutar)

#align(center)[= Interrupcion de Hardware]
Se interrumple la ejecucion del programa activando alguna de las dos entradas que tiene el microprocesador (INTR y NMI). Es un evento externo al procesador

- El flag *IF* indica si se debe atender a las interrupciones externas. Si *IF = 1 (habilitado)* si IF = 0 (deshabilitado)

- *Interrupcion enmascarable*: El flag IF se controla con las instrucciones _sti_ (set interrupts) y _cli_ (clear interrupts)

- *Interrupcion NO enmascarable*: Las interrupciones que ingresan por la patita NMI no pueden ser enmascaradas. Y siempre ejecutan la rutina que se encuentra en la posicion 2h del vector de interrupciones (INT 2h)

== Interrupcion IMR vs NMI:
- Las IMR son "criticas"
- Las NMI son "normales"
  - Ejemplo: El teclado es una interrupcion NMI, el mouse lo mismo

= PIC (Controlador programable de interrupciones)

- Gestiona interrupciones hasta 8 perifericos

- Interrupcion vectorizada

- IDT: *Interrupt descriptor table* $->$ tabla que contiene punteros a todas las *rutinas de atencion de interrupcion*. Al inicio la IDT esta vacia, linux llena la 80h con un puntero al sistema operativo, por eso *cuando hacemos syscalls*, se dice que estamos *"llamando al sistema operativo"*



_RTOS $->$ Real time operating systems_: Sistemas criticos que tienen mas control sobre las interrupciones
























