= Transmision digital

Hay muchas representaciones e interpretaciones que se le pueden dar al codigo
binario, por ejemplo puede significarse:

$ 0 -> 5 "Volts" $

$ 1 -> -5 "Volts" $

\

== Transmision en serie

$ "Reciever" <- 0 1 0 1 1 0 1 0 1 1 1 <- "Sender" $

\

== Transmision paralela - Bus

#align(center)[#table(columns: 3)[Reciever][#table(columns: 1)[$ <- 0 1 0 1 ... <- $][$ <- 0 1 0 1 ... <- $][$ <- 0 1 0 1 ... <- $]][Sender]]


= Tipos de Arquitectura

== Von Neumann

#table(columns: 3)[Memoria de codigo y de datos][$<=$ Buses $=>$][CPU]

== Harvard

#table(columns: 3)[Memoria de codigo y de datos][$<=$ Buses $=>$][CPU]

Vas al codigo y lo tenes de un lado, vas del otro lado y tenes los datos

\

*Ventajas*
- Puedo ejecutar codigo e ir a buscar datos en paralelo

- Mas eficiente

\

*Desventajas*
- Mas costoso

- Mas dificil de hacer

_Hoy en dia se usa Von Neumann_


== Procesadores ARM

Tiene _Harvard_ modificada. *Tiene lo mejor de los dos mundos*


= Sistema de Entrada y Salida

En una computadora necesitas:

- Memoria

- CPU

- Sistema de Entrada y Salida

- TODOS ven la informacion de todos, la diferencia es como interpretan los datos

#import "@preview/cetz:0.3.1": canvas, draw

#align(center)[
  #canvas(length: 0.7cm, {
    import draw: *
    
    // Definir posiciones de los componentes
    let cpu-pos = (7, 5)
    let memory-pos = (-2, 5)
    let io-pos = (-2, 1)
    let bus-center = (2.5, 3)
    
    // CPU - Rectángulo azul claro
    rect(
      cpu-pos,
      (cpu-pos.at(0) + 4, cpu-pos.at(1) + 2),
      fill: rgb("#B3E5FC"),
      stroke: black + 1pt
    )
    content(
      (cpu-pos.at(0) + 2, cpu-pos.at(1) + 1),
      text(size: 14pt, weight: "bold")[CPU]
    )
    
    // Memoria - Rectángulo naranja
    rect(
      memory-pos,
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 2),
      fill: rgb("#FFB74D"),
      stroke: black + 1pt
    )
    content(
      (memory-pos.at(0) + 1.75, memory-pos.at(1) + 1),
      text(size: 14pt, weight: "bold")[Memoria]
    )
    
    // Sistema de Entrada y Salida - Rectángulo amarillo
    rect(
      io-pos,
      (io-pos.at(0) + 3.5, io-pos.at(1) + 2),
      fill: rgb("#FFF176"),
      stroke: black + 1pt
    )
    content(
      (io-pos.at(0) + 1.75, io-pos.at(1) + 1.5),
      text(size: 11pt, weight: "bold")[Sistema de]
    )
    content(
      (io-pos.at(0) + 1.75, io-pos.at(1) + 0.8),
      text(size: 11pt, weight: "bold")[Entrada y Salida]
    )
    
    // Buses - líneas verdes
    // Bus horizontal superior (hacia CPU)
    line(
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 1.2),
      (cpu-pos.at(0), cpu-pos.at(1) + 1.2),
      stroke: rgb("#66BB6A") + 3pt
    )
    line(
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 1),
      (cpu-pos.at(0), cpu-pos.at(1) + 1),
      stroke: rgb("#66BB6A") + 3pt
    )
    line(
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 0.8),
      (cpu-pos.at(0), cpu-pos.at(1) + 0.8),
      stroke: rgb("#66BB6A") + 3pt
    )
    
    // Bus vertical (conexión T)
    line(
      (bus-center.at(0), memory-pos.at(1) + 1),
      (bus-center.at(0), io-pos.at(1) + 1.5),
      stroke: rgb("#66BB6A") + 3pt
    )
    line(
      (bus-center.at(0) - 0.2, memory-pos.at(1) + 1),
      (bus-center.at(0) - 0.2, io-pos.at(1) + 1.5),
      stroke: rgb("#66BB6A") + 3pt
    )
    
    // Bus horizontal inferior (hacia I/O)
    line(
      (io-pos.at(0) + 3.5, io-pos.at(1) + 1.5),
      (bus-center.at(0), io-pos.at(1) + 1.5),
      stroke: rgb("#66BB6A") + 3pt
    )
    line(
      (io-pos.at(0) + 3.5, io-pos.at(1) + 1.3),
      (bus-center.at(0), io-pos.at(1) + 1.3),
      stroke: rgb("#66BB6A") + 3pt
    )
    
    // Círculo rojo en la intersección
    circle(
      (bus-center.at(0) - 0.1, memory-pos.at(1) + 1),
      radius: 0.5,
      stroke: red + 2pt,
      fill: none
    )
    
    // Flechas bidireccionales
    // Flecha Memory <-> Bus
    line(
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 1.5),
      (memory-pos.at(0) + 4.2, memory-pos.at(1) + 1.5),
      stroke: black + 1.5pt,
      mark: (end: ">", fill: black)
    )
    line(
      (memory-pos.at(0) + 4.2, memory-pos.at(1) + 0.5),
      (memory-pos.at(0) + 3.5, memory-pos.at(1) + 0.5),
      stroke: black + 1.5pt,
      mark: (end: ">", fill: black)
    )
    
    // Flecha CPU -> Bus (flecha roja)
    line(
      (cpu-pos.at(0) - 0.7, cpu-pos.at(1) + 1),
      (cpu-pos.at(0), cpu-pos.at(1) + 1),
      stroke: rgb("#EF5350") + 2pt,
      mark: (end: ">", fill: rgb("#EF5350"))
    )
    
    // Flecha I/O <-> Bus
    line(
      (io-pos.at(0) + 3.5, io-pos.at(1) + 1.8),
      (io-pos.at(0) + 4.2, io-pos.at(1) + 1.8),
      stroke: black + 1.5pt,
      mark: (end: ">", fill: black)
    )
    line(
      (io-pos.at(0) + 4.2, io-pos.at(1) + 1.2),
      (io-pos.at(0) + 3.5, io-pos.at(1) + 1.2),
      stroke: black + 1.5pt,
      mark: (end: ">", fill: black)
    )
    
    // Etiqueta de Buses con flecha azul
    rect(
      (4.5, 2),
      (8.5, 0.2),
      fill: white,
      stroke: black + 1pt
    )
    
    // Flecha azul apuntando a los buses
    bezier(
      (4.3, 1.2),
      (bus-center.at(0) + 0.3, io-pos.at(1) + 1.5),
      (3.5, 1.2),
      (bus-center.at(0) + 0.5, io-pos.at(1) + 1.3),
      stroke: rgb("#5C6BC0") + 2pt,
      fill: rgb("#5C6BC0"),
      mark: (end: ">", fill: rgb("#5C6BC0"))
    )
    
    content(
      (6.5, 1.5),
      text(size: 14pt, weight: "bold")[Buses]
    )
    content(
      (6.5, 0.8),
      text(size: 11pt)[(de direcciones y de]
    )
    content(
      (6.5, 0.4),
      text(size: 11pt)[datos)]
    )
  })
]

\

= Read vs Write

Hay un flag que pasa el sistema operativo que dice si estas en modo read o en
modo write

- Para saber que instruccion tiene que ejecutar, va a estar en *modo lectura*
y va a ir trayendo los bytes correspondientes que representan la instruccion 
que tiene que ejecutar proximamente

_Entonces para cualquier instruccion, en algun momento el procesador va a estar
en modo lectura_


=== Instruccion de escritura

Va a leer lo que esta en 2000h y lo va a poner en al. Esto es una instruccion de
lectura, ya que escribir en registros no es lo mismo que escribir en memoria

```asm
mov al, [2000h]
```


=== Instruccion de lectura

Va a leer lo que se tiene en el registro bl y luego va a *escribir en memoria*,
mas especificamente en 2000h, lo que leyo de bl. Por lo tanto

```asm
mov [2000h], bl
```

\

= Mapa de memoria

Todas las direcciones que puede acceder una CPU

#align(center)[#table(columns: 1)[RAM][ROM][Perifericos]]

== Ejercicio

$ballot$ Supongamos un procesador que tiene 16 lineas (o patitas) de bus de 
direcciones y 8 lineas de bus de datos

_En el bus de direcciones_

$ 16 "patitas" -> 16 "ceros" -> "Dir min" = 0000h, "Dir max" = "FFFF"h $

$ 2^16 "bits" $


_En el bus de datos_
Solo tenemos *1 Byte*, entonces el "ancho de los renglones" va a ser de *1 Byte*


$ #table()[$ #sym.therefore 2^16 times 1 "Byte" = 64 "KB" $] $

_Esto quiere decir que la sumatoria de RAM + ROM + Perifericos tiene que ser de
64KB_


$ballot$ Que cantidad de informacion puede acceder?


== Ejercicio 2

$ballot$ Y un procesador que tiene 16 lineas de buss de direcciones y 16 lineas
de bus de datos?

$ "Dir min" = 0000h, "Dir max" = "FFFF"h $

Pero como el bus de datos tiene 16 lineas, entonces "por cada renglon" 
entrarian $16 "bits" -> 2 "Bytes"$


$ballot$ Y un procesador de 32 Bus de Address y 32 de Bus de Datos

$ "Dir min" = 00000000h, "Dir max" = "FFFFFFFF"h => 2^32 "Direcciones de memoria" $

Luego el "ancho de renglon" -> size del bus de datos, va a ser de 32 bits -> 4 Bytes

$ #table()[$ #sym.therefore 2^32 times 4 "Bytes" = 16G $] $

== Ejemplo 3

Tenemos un procesador con un *bus de address* de 32 "patitas" y tiene 8 patitas
de *bus de datos*

_Notemos que_ si tenes un bus de address de 32 patitas, es decir, se pueden
transmitir 32 bits a la vez, quiere decir que necesitas tener *punteros de 32
bits* porque son los que terminan apuntando a la memoria.

#align(center)[#table[$ #sym.therefore "Las \"patitas\" estan directamente relacionadas a los punteros que usa el procesador" $]]




































