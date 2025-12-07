#set document(
  title: "Preguntas de Final Arquitectura de Computadoras",
  author: "Juan Ignacio Raggio",
)

#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 2cm,
    right: 2cm,
  ),
  numbering: "1",
  number-align: bottom + right,

  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Juan Ignacio Raggio],
      [],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],

  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Pagina #counter(page).display() / #counter(page).final().first()
    ]
  ]
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "es",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
  spacing: 1.2em,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")

#show heading: it => {
  v(0.5em)
  it
  v(0.3em)
}

#set list(indent: 1em, marker: ("•", "◦", "▪"))
#set enum(indent: 1em, numbering: "1.a.")

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#show link: underline
// ====================================
// PORTADA
// ====================================

#align(center)[
  #v(1em)
  #text(size: 24pt, weight: "bold")[Arquitectura de Computadoras]
  #v(0.5em)
  #text(size: 18pt)[Preguntas de Final]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Practica Teorica \
    #datetime.today().display("[day]/[month]/[year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

// ====================================
// FUNCIONES UTILES
// ====================================

// Funcion para crear una caja de nota/observacion
#let nota(contenido) = {
  block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1976D2"))[Nota:] #contenido
  ]
}

// Funcion para crear una caja de advertencia
#let importante(contenido) = {
  block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#F57C00"))[Importante:] #contenido
  ]
}

// Funcion para crear una caja de error comun
#let error(contenido) = {
  block(
    fill: rgb("#FFEBEE"),
    stroke: rgb("#D32F2F") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#D32F2F"))[Error Comun:] #contenido
  ]
}

// Funcion para crear una caja de tip
#let tip(contenido) = {
  block(
    fill: rgb("#E8F5E9"),
    stroke: rgb("#388E3C") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#388E3C"))[Tip:] #contenido
  ]
}

// Funcion para crear una caja de duda con pregunta y respuesta
#let doubt(pregunta, respuesta) = {
  block(
    fill: rgb("#F3E5F5"),
    stroke: rgb("#7B1FA2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Pregunta:]
    #v(0.3em)
    #pregunta
    #v(0.5em)
    #line(length: 100%, stroke: 0.5pt + rgb("#7B1FA2"))
    #v(0.5em)
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Respuesta:]
    #v(0.3em)
    #respuesta
  ]
}

= Preguntas teoricas de verdadero o falso

1. Al querer iniciar un programa, siempre se asigna el espacio de memoria antes
  que el jmp a la dirección de memoria del programa

- [F] Un programa podria solo hacer operaciones con registros y no necesitar
  memoria 

2. La memoria de un programa está compuesta únicamente por Código, Datos, Heap 
  y Pila

- [V]

3. En la sección de Datos se guardan las variables locales de una función. 

- [F] Las variables locales de una funcion se *guardan en el stack*, en la
  seccion de datos, se guardan las variables globales y estaticas que se cargan
  al iniciar el programa

4. Tanto en Linux como en Windows, la extensión de un archivo es quien 
  determina el tipo de archivo

- [F] En Linux, la extensión en los archivos es una "ayuda" visual para que los 
  humanos puedan distinguir entre tipos de archivos, pero en realidad son todos 
  binarios, la diferencia es la forma en la que se interpretan y
  eso se define en los encabezados y en el caso de Windows, el sistema 
  operativo si depende de las extensiones

5. Para llamar a funciones dentro de assembler (asumiendo arquitectura de 32 
  bits), es lo mismo hacer CALL  ‘función‘, que hacer 
  push ESP -> jmp  ‘función ‘

- [F] Lo que debe pushearse es la *siguiente instruccion a la que apuntaria*,
  una vez se quiera volver de la funcion, es decir el `eip`

#error[
  Ojo, el `esp` era stack pointer, me lo habia confundido con el `eip`, error
  garrafal
]

6. Si tenemos un ejecutable el cual podemos correr, y cambiamos algunos bits en 
  el .o, reemplazando quizás unas letras de un string, al volver a correr el 
  ejecutable, estas letras estarán cambiadas en el string en cuestión.

- [F] Deberias volver a linkeditar, ya que el ejecutable fue generado con el .o
  anterior, por lo que no habria ninguna modificacion

7. Sabemos que la comunicación entre SO y User Space está dada por las Syscalls
  El SO no analiza continuamente las instrucciones que se corren, es decir, no 
  se queda "escuchando", sino que cuando desde el User Space se hace una 
  syscall, el SO interrumpe sus tareas y lleva a cabo dicha syscall.

- [V] Porque el SO no se esta ejecutando, sino que se esta ejecutando una 
  aplicacion de User Space, mediante esa interrupcion, se pasa a ejecutar 
  codigo del Kernel Space y ese codigo son las rutinas que se ejecutan, 
  dependiendo de la syscall que se desea ejecutar

8. Hay por lo menos una syscall la cual recibe un puntero a función y lo corre 
  desde el SO

- [F] Pues las syscalls justamente ejecutan codigo en el Kernel Space, el cual
  no tiene nada que ver con User Space, pasar un puntero a funcion seria 
  decirle al Kernel que ejecute una rutina de la cual no tiene contexto y no
  tiene ningun tipo de control de la misma, significaria que el User Space 
  puede ejecutar cualquier instruccion sin ningun tipo de control

9. Olvidándonos de los permisos, si yo quiero acceder a una posición de memoria 
  del stack, siempre lo único que necesito es el ESP (asumiendo 32 bits)

- [F] Pues tambien se necesita conocimiento del Stack Segment que indica el
  segmento de memoria que le corresponde al stack

10. En un instante de tiempo siempre hay exactamente un programa ejecutándose, 
  sin excepciones

- [V] Pues solo hay un procesador

11. Una persona no puede hacer mov ah, 12345678h

- [V] Pues en ah solo entra un byte y 12345678h es de 4 bytes


#doubt[
  La verdad que esto no lo entendi bien
  12. Existe un requisito importante para los sistemas operativos Multitarea que 
    es tener espacio de memoria individual para cada tarea, y un espacio de 
    memoria común para varias tareas
][
  // Esta respuesta estaba en apuntes nash pero para mi no esta respondiendo
  // a la pregunta que le estan haciendo
  // La respuesta es *Verdadero* porque cuando se tienen muchos programas abiertos
  // a la vez, en realidad hay uno solo corriendo (a la vez), lo que esta pasando
  // es que se va switcheando tan rapido entre la ejecucion de los programas que
  // termina siendo imperceptible
  Verdadero: Es importantisimo que cada proceso tenga su memoria privada para
  que otro proceso que no deberia, acceda a su informacion. Ademas en caso de
  que haya un fallo, solo se ve afectada la memoria del programa que fallo y
  no TODA la memoria. Finalmente brinda independencia porque le hace creer al 
  programa que tiene toda la memoria para el. Por otro lado tambien es 
  necesaria la *memoria compartida* ya que hay procesos que podrian querer 
  comunicarse y el codigo compartido como librerias e incluso recursos del 
  kernel que no tendria sentido tenerlo repetido para cada proceso que los 
  necesite.
]


13. De apagar la PC, al volverla a prender, en la memoria RAM, en un inicio 
  puedo asegurarme de que todos los bits estarán en 0

- [F] Depende de que es "en un inicio" podriamos considerar dos situaciones 
  distintas, porque en realidad cuando se enciende
  la computadora, primero se setean recursos necesarios del Kernel como 
  la IDT, GDT, segmentos, estructuras del Kernel, etc. 
  Por lo que no va a estar vacia, si estamos hablando de un inicio antes de el 
  seteo de recursos, tampoco podriamos asegurar que la RAM este en 0 ya que 
  podria haber ruido por la naturaleza del hardware. El estado de la RAM va a 
  depender de condiciones fisicas externas que no estan especificadas en el 
  enunciado, por lo que naturalmente si no hay una intervencion en cuanto a 
  condiciones fisicas (principalmente climaticas), no deberiamos poder asegurar 
  que todos los bits estan en 0

14. Es ilegal hacer mov [100h], [eax].

- [V] Primero porque no sabemos que es o a quien le corresponde la zona de 
  memoria 100h, segundo porque el compilador no va a saber cuantos bytes mover
  ya que en la direccion de memoria a donde "apunta" eax, puede tener cualquier
  "cosa", por lo tanto no va a tener idea cuantos bytes tiene que mover y lo
  mismo en la direccion 100h, no podemos saber cuantos bytes "deberian entrar".
  Tercero y mas importante, no existe mov con source y destination como 
  direcciones de memoria, alguno de los dos tiene que ser un registro.

15. Solo contamos con las siguientes secciones: .text y .data.

- [F] Tambien existe .rodata, .bss

16. Una ventaja de Linux es la portabilidad, lo que se suele cambiar es código 
  de C y no de asm para adaptarlo a otro hardware

- [F] Justamente Linux es portable porque el codigo de C no deberia cambiar 
  cuando cambiamos de hardware, lo que podria llegar a cambiar es el codigo en 
  assembler, por ejemplo en caso de cambiar la cantidad de bits del procesador,
  cambia el size limite de los registros a usar y por ende, la convencion de 
  pasaje de parametros a funciones de C, para interoperar con assembler tambien 
  podria cambiar.

17. La E en ESP stands for Extended, y la R en RSP stands for Requete-Extended.

- [F] Probablemente no pero RSP tiene el doble de size que ESP

18. En 32 bits, el valor de retorno de una función de C llamada desde asm 
  siempre se guarda en eax

- [F] Depende del size de lo que se desea retornar, en caso de que sea menor o
  igual a 8 bytes, si. En caso de que sea mayor a 8 bytes, hay un fallback a
  usar edx:eax, en caso de que sea aun mayor a 16 bytes, se retorna un puntero

19. El canary se coloca entre el EBP y las variables locales.

- [V] Ya que justamente sirve para que en caso de tener un buffer como variable
  local y el usuario tenga que escribir en el mismo, si hay un bufferoverflow,
  se pisa antes el canary que el ebp o el ret value

20. La GOT se utiliza para resolver direcciones las cuales no son conocidas al 
  momento de linkedición

- [V] La Global Offset Table, brinda justamente offsets dentro de un segmento,
  para poder ubicar direcciones de memoria importantes como funciones, de forma
  relativa, asi podria cambiarse la direccion de memoria en donde se ejecuta
  el codigo sin afectar su funcionamiento, de hecho esto es lo que sucede para
  evitar ataques de fuerza bruta

#doubt[
  Esto todavia no lo vi, tengo que estudiar la teoria de los ultimos temas
  21. El tipo de memoria SRAM se suele utilizar para la caché. 
][
  Verdadero
]

#doubt[
  Lo mismo esto, no me lo acuerdo bien
  22. Las DRAM a pesar de ser no volátiles, no necesitan un refresco de memoria
][]


#doubt[
  Lo mismo
  23. El Tiempo de Acceso de una memoria se compone de la latencia y la transferencia
][]

24. La patita IO/M, si vale 1 hay operaciones con periféricos, si vale 0 con la 
  memoria

- [V] Con 1 se accede al mapa de entrada salida

#doubt[
  La verdad que de esto no tenia ni idea
  25. En un sistema de Entrada y Salida existe el acceso directo a memoria, sin 
    la intervención de la CPU.
][
  Verdadero los perifericos que manejan grandes cantidades de bytes, usan un
  concepto llamado DMA (Direct Memory Access) que agiliza la escritura y acceso
  a memoria sin pasar por el CPU, esto evita que el mismo se sature a la hora
  de mover grandes cantidades de bytes
]


26. La única entrada de interrupción de hardware que hay en el micro es la INTR

- [F] Existe la NMI Non-Mascarable Interrupt

27. La instrucción sti es para habilitar las interrupciones, cli para 
  detenerlas

- [V] sti (SeT Interrupt flag), cli (CLear Interrupt flag).

28. De estar el flag IF en 1, las interrupciones estarán habilitadas.

- [V]

29. No hay un valor específico el cual el EOI le envía al PIC

- [F] Le envia el valor 20h

30. En la IDT únicamente hay interrupciones de software y de hardware

- [F] En la IDT tambien estan las excepciones

31. Sabiendo que 0FEh son los bits necesarios para habilitar únicamente la 
  interrupción de teclado en el PIC. Para hacer esto, sin preocuparnos por 
  detalles como perder el valor que estaba en al, una rutina de assembler 
  posible sería: 

  mov al, 0FEh 
  Out 20h, al

- [F] Deberia usarse el puerto 21h en vez del 20h

32. Si alguien hace cli y justo después hlt, la CPU se quedará sin hacer nada y
  no hay forma de ejecutar una interrupción para que se salga del hlt

- [F] Si una interrupcion llega por la NMI, como no es enmascarable, va a hacer
  que el cpu salga del hlt

33. Una excepción la cual puede corregirse es llamada un abort

- [F] Las excepciones de tipo abort justamente no pueden corregirse, suelen ser
  errores de hardware criticos o errores como double fault que son excepciones
  que ocurren cuando se esta manejando otra excepcion

34. ¿Quién se da cuenta (lanza la excepción) de que un programa está accediendo
  a una zona para la cual no tiene permisos?
  1- El micro
  2- El SO
  3- El PIC

- [1] El microprocesador (hardware) es el que se encarga de chequear si la 
  memoria a la que un programa esta accediendo le corresponde, ya que como
  el sistema operativo no corre "a la vez" que otros programas, quiere decir
  que para saber si se modifico una zona "prohibida", tendria que chequear todo
  el tiempo (cada 55ms) TODA la memoria y no tiene sentido

35. ¿Cómo sabe el micro dónde está la IDT para acceder a la misma cuando se 
  ejecuta una interrupción?

  1- CR3
  2- Está siempre en la misma posición de memoria sin importar el SO
  3- Magia
  4- Hay un registro IDTR especial para esto.

- [4] Hay un registro IDTR especial con el que se le indica

36. Se llama modo Flat a aquel que tiene la unidad de segmentación desactivada.

- [F] No se desactiva pero se "bypasea"

37. Si empiezo mi equipo con las unidades de Segmentación y Paginación 
  prendidas, tanto el tamaño de las páginas como el tamaño de los segmentos 
  será siempre el mismo.

- [F] Los segmentos son de variable size y ademas las paginas en sistemas 
  modernos tambien pueden tener distintos sizes

38. ¿Cuál de los siguientes no es un registro de segmento?
  1- CS
  2- GS
  3- PS
  4- FS

- [PS] No existe

39. Un segmento tiene 2 niveles de privilegio, 0 para Kernel Space, 1 para User 
  Space.

- [F] Existen 4 niveles de privilegio, ring 0 que es el kernel space, ring 1 y 
  2 que no se utilizan y ring 3 que es user space

40. Si alguien fuese a poner un 4 en el IOPL de los EFLAGS. ¿Qué pasaría?
  1- No cambiaría mucho, normalmente está en 4.
  2- Estaría habilitando a programas del Kernel Space y el User Space a usar 
    instrucciones de Entrada/Salida.
  3- Solamente el Kernel Space podría usar instrucciones de E/S.
  4- Ni siquiera el Kernel Space podría usar instrucciones de E/S

- [2] Poner un 4 seria como encender los os bits, lo cual le da acceso a todos
  los niveles de privilegio a ejecutar in/out 
  *(IOPL = Input Output Privilege Level)*

41. El Task State Segment se utiliza para:
  1- Guardar el contexto de ejecución.
  2- Cumple una función similar a la IDT.
  3- Tiene los descriptores de los distintos segmentos
  4- Ninguna de las anteriores

- [1]

42. El GDT es quien guarda los descriptores de los distintos segmentos

- [V]

43. ¿Quién es el encargado de pasar una dirección virtual a física?

- La Memory Management Unit transforma una direccion virtual a su equivalente
  en fisica

44. Dos páginas en la memoria virtual de dos procesos distintos no pueden ser 
  exactamente la misma página en la memoria física.

- [F] Si pueden ser exactamente la misma pagina, el detalle es que no pueden
  estar en memoria RAM en simultaneo, es decir uno de los dos deberia estar
  en disco

#doubt[
  Todavia no vi memoria cache
  45. Para Caché se usa Dynamic RAM
][]


47. La arquitectura AMD64 no es compatible con 32 bits.

- [F] Si es compatible






