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


= Servicios de BIOS - Basic Input Output System

El BIOS al iniciar la PC guarda en memoria rutinas basicas para poder empezar a operar

#table(columns: 2)[int 10h][Rutinas de video (BIOS)][int 13h][Rutinas de disco (BIOS)][int 14h][Rutinas para puerto serie (BIOS)][int 19h][Rutinas para bootloader (BIOS)][int 1Ah][Rutinas para el RTC (BIOS)]

\

= Interrupciones de hardware por default

#table(columns: 3)[*Linea IRQ*][*INT Tipo*][*Descripcion*][IRQ0][08h][Timmer tick (18.2 veces por segundo)][IRQ1][09h][Teclado][IRQ2][0Ah][INT desde 8259A esclavo][IRQ8][70h][Servicio de reloj en tiempo real][IRQ9][71h][Redireccionamiento por soft a IRQ2][IRQ10][72h][Reservada][IRQ11][73h][Reservada][IRQ12][74h][Reservada][IRQ13][75h][Coprocesador numerico][IRQ14][76h][Conttrolador de disco rigido][IRQ15][77h][Reservada][IRQ3][0Bh][COM2][IRQ4][0Ch][COM1][IRQ5][0Dh][LPT2][IRQ6][0Eh][FLOPPY][IRQ7][0Fh][LPT1]

\

#align(center)[= Excepciones]

Una Excepcion es exactamente igual que la interrupcion

- Se va a la IDT
- Se va al puntero
- Se ejecuta la rutina

La dif esta en "quien las genera?"

Son eventos *generados por el procesador* cuando detecta una o mas condiciones predefinidas al ejecutar una instruccion

Existen 3 tipos de excepciones:

+ *Faults:* Excepcion que puede corregirse. El procesador guarda en la pila la direccion de la instruccion que produjo la falla

+ *Trap:* Se utilizan para realizar accesos al sistema operativo

+ *Abort:* No siempre se puede obtener la instruccion que causo la excepcion. Reporta errores severos

De la tabla de interrupciones (IDT) las primeras 32, son las excepciones. Acutalmente se estan utilizando 20 de ellas y el resto quedan disponible para uso futuro.

== Lista de excepciones:

1 Divide error
2 Debug exceptions
3 Nonmaskable interrupt
4 Breakpoint (one-byte INT 3 instruction)
5 Overflow (INTO instruction)
6 Bounds check (BOUND instruction)
7 Invalid opcode
8 Coprocessor not available
9 Double fault
10 (reserved)
11 Invalid TSS
12 Segment not present
13 Stack exception
14 General protection $->$ _la de la pantalla azul_
15 Page fault
16 (reserved)
17 Coprecessor error
17-31 (reserved)
32-255 Available for external interrupts via INTR pin


=== Linux - Unix

Sistema operativo que maneja mucho mejor los procesos que windows, por eso se considera *mucho mas confiable*

\

= Interrupciones en Multi-Core


= Overclocking

- Los procesadores trabajan a cierta frecuencia

- Hubo gente que si le vio que si le subis la frecuencia $->$ el procesador anda mas rapido

- El problema es que levanta temperatura, pero para que no se fundan por temperatura, se arman circuitos para refrigerar temperaturas

















