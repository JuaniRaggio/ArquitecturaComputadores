#set document(
  title: "Tips y Errores Comunes - Arquitectura",
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
      Pagina #counter(page).display() de #counter(page).final().first()
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

// ====================================
// PORTADA
// ====================================

#align(center)[
  #v(1em)
  #text(size: 24pt, weight: "bold")[Arquitectura de Computadoras]
  #v(0.5em)
  #text(size: 18pt)[Tips y Errores Comunes]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Guia de referencia rapida para el parcial \
    #datetime.today().display("[day] de [month repr:long] de [year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

= Tips Generales

#tip[
  Todas las posiciones de memoria de Intel ocupan 1 Byte. Esto es importante para entender el direccionamiento y el uso de registros.
]

#tip[
  La estandarizacion de espacio busca eficiencia de acceso a costa de espacio en memoria.
]

#tip[
  Acceso a letra dentro de un string: usar registros de 4 bits (AL, BL, etc).
  Esto hace que no necesitemos agregar explicitamente la keyword BYTE ya que
  el compilador sabe el tamaño de AL, BL, etc
]

= Assembler x86

== Syscalls

#error[
  No olvidarse del `int 80h` al hacer syscalls. Es muy facil olvidarlo y el programa no va a funcionar
]

```yasm
;; Syscall correcta
mov eax, 1    ; sys_exit
mov ebx, 0    ; codigo de retorno
int 80h       ; NO OLVIDAR ESTO
```

#tip[
  Usar `strace` para interceptar y debuggear las system calls de un programa:
  ```bash
  strace ./programa
  ```
]

#importante[
  Hacer la syscall de exit permite no tener que hacer armado y desarmado de stack frame en la funcion `_start`.
]

== Size de Operandos

#error[
  Cuando se hace un `mov` con punteros, SI o SI especificar la cantidad de bytes:
  ```yasm
  mov byte [esi], 0   ; BIEN -> especificar 1 byte
  mov [esi], 0        ; MAL -> El compilador no sabe cuantos bytes tiene que copiar
  ; Le surge la duda de "Puntero a que?". Aclarando con la keyword, se elimina esa
  ; ambiguedad
  ```
]

#nota[
  Las opciones de size son:
  - `byte` → 1 byte
  - `word` → 2 bytes
  - `dword` → 4 bytes
  - `qword` → 8 bytes
]

== Registros

#importante[
  Registros que se deben preservar (caller-saved):
  - `edx`
  - `esi`
  - `edi`
  - `ebp`
  - `esp`
]

_Notemos que si nos dicen que preservemos estos registros, quiere decir que
todas las funciones que llames desde assembly de libc, van a preservar estos
registoros._

#tip[
  Si el sistema necesita optimizaciones, se puede evitar el backup de registros, pero esto depende de cada caso particular. Y esta abierte la eleccion 
  para que el programador elija
]

#tip[
  Para copiar una direccion de memoria con un offset, podemos usar la
  instruccion `lea`, que tambien *es importante saberla* ya que es comun
  que la pongan en ejemplos de assembler. _Ambas opciones a continuacion 
  son equivalentes_
  ```yasm
  mov eax, 0x6c6c6c6c ; Supongamos que es una direccion valida
  mov esi, eax        ; Movemos la direccion a esi (source index)
  add esi, 4          ; Es comun hacer esto cuando queremos recorrer un array
  ;; ====== Seria exactamente igual hacer ======
  lea esi, [eax + 4]  ; Notemos que es mas corto y practico
  ```
]


= Stack y Stack Frames

== Armado y Desarmado

#importante[
  Siempre armar el stack frame al inicio de una funcion y desarmarlo antes de retornar:

  Armado:
  ```asm
  push ebp
  mov ebp, esp
  ```

  Desarmado:
  ```asm
  mov esp, ebp
  pop ebp

  ; Otra opcion equivalente:
  leave
  ```
]

#tip[
  Hacer el seguimiento de la pila y *no borrar lo que ya se escribio*
]

== Acceso a Parametros

#nota[
  En x86 (32 bits), los parametros se pasan por la pila. Para acceder al primer parametro (*en caso de haber hecho armado de stack frame!!!!!!!*):
  ```asm
  mov ax, [ebp + 8]
  ```
  _Pues tenemos:_
  #align(center)[#table(columns: 1)[ebp][Direccion de retorno][param1][param2][...]]
]

#tip[
  En arquitectura de 64 bits, los parametros se pasan primero por registros y luego por la pila. Esto ayuda a evitar inyeccion de codigo.
]

== Valores de Retorno

#importante[
  Convencion de retorno en C:
  - Menor a 32 bits: retorna en `EAX`
  - Mayor a 32 bits: parte alta en `EDX`, parte baja en `EAX`
  - Estructuras complejas: retorna un puntero formado por `EDX:EAX`
]

== Errores Comunes

#error[
  Si una funcion altera flags (como el flag Z), puede romper ciclos que dependen de ese flag. :
  ```yasm
  dec ecx
  call procesar    ; si procesar altera el flag Z
  jz fin           ; este salto puede no funcionar correctamente
  ```
  #align(center)[La solucion sencilla es que *todas las funciones se encarguen de dejar el estado del procesador como se recibio*, es decir backupear las flags]
]

#error[
  La informacion queda intacta despues de hacer `POP`. Esto puede ser un problema de seguridad (analisis forense de memoria).
]

= Memoria

== Conceptos clave

#tip[
  Formula para calcular *espacio de memoria*:
  $ 2^("bits bus address") times "bytes bus de datos" $
  Ejemplo: 32 bits address, 32 bits datos $2^32 times 4 "bytes" = 16"GB"$
]

#importante[
  Las "patitas" del bus de address estan directamente relacionadas a los punteros que usa el procesador. Un bus de 32 bits necesita punteros de 32 bits.
]

#nota[
  Tipos de memoria:
  - RAM (volatil, rapida, se pierde al apagar)
  - ROM (no volatil, lenta, persiste al apagar)
  - SRAM (rapida, costosa, usada en cache, no necesita refresco)
  - DRAM (mas lenta, economica, necesita refresco)
]

== Mapeo de Memoria

#tip[
  Ventajas del mapeo en memoria:
  - Mayor cantidad de instrucciones disponibles
  - Modificacion directa de registros del periferico sin usar `IN`/`OUT`

  Desventajas:
  - Reduce cantidad de memoria disponible (impactominimo hoy en dia)
]

= Paginacion y Memoria Virtual

== Conceptos Clave

#importante[
  La paginacion divide la memoria en tamanos fijos (tipicamente 4KB). Esto reduce la fragmentacion de memoria.
]

#nota[
  Las paginas siempre empiezan en multiplos de tamano de pagina (esto quiere decir que estan alineadas).
]

== Ejercicios de Paginacion

#tip[
  Todos los ejercicios de paginacion siguen el mismo patron:
  - Mapa virtual: su tamano depende del bus de address del procesador
  - Mapa fisico: su tamano depende de la cantidad de RAM
  - Registro CR3: contiene la *direccion fisica* de la *tabla de directorio*
  - Bit P (presente): indica si esta en RAM o en disco
]

#importante[
  En sistemas de 64 bits con 2MB de tamano de pagina:
  - Paginas alineadas a 2MB necesitan 21 bits para offset
  - "Tamano de pagina - 1" debe ser el valor maximo obtenido con todos los bits del offset en 1
]

#error[
  No poner CR3 (posicion del directorio) en una zona que pueda ser sobrescrita.
]

= Seguridad

== Stack Overflow

#error[
  Nunca usar `gets()`. Esta funcion permite escribir en memoria sin limite, permitiendo ataques de Stack Overflow donde un atacante puede inyectar codigo malicioso.
]

#tip[
  El canary de alguna forma reduce el impacto de este problema, interponiendose entre las variables locales (*en caso de haber buffers*) y el ebp/retorno.
  El esquema seria el siguiente:
  #align(center)[#table(columns: 1)[_Buffer_][*canary*][ebp][Direccion de retorno][param1][param2][...]]
  En caso de que se exceda del limite del buffer, ejemplo:
  ```c
  char buff[3] = {0};
  buff[4]; // ME EXCEDO DEL LIMITE Y PISO EL CANARY
  ```

  En vez de pisar el *ebp* o la *direccion de retorno* (MUY PELIGROSO POR POSIBLE RCE), pisas el canary.
  Despues al final de la funcion, antes de popear el ebp y el retorno, te fijas si el canary cambio, en caso de que se hayan excedido del buffer, el canary cambia, por lo que se arroja un error
]

#importante[
  El canary debe estar explicito en el codigo ASM si se quiere usar como proteccion. En el caso de que nos pasen un codigo de C que contenga un buffer, *el compilador agrega el canary a menos de que le pidas explicitamente que no lo haga*, esto quiere decir que si piden el seguimiento de pila de un codigo en C y contiene un buffer, *si o si va a estar el canario perez*
]

#nota[
  Concepto de inyectar codigo:
  - Sigue pasando en otros lenguajes
  - Si un programa se puede romper con un error, esta mal programado
  - Para encontrar direcciones especificas se usan scripts
]

= Interrupciones

== Conceptos

#tip[
  Polling vs Interrupciones:
  - Polling: consulta constantemente "tenes un dato?"
  - Interrupciones: "cuando tengas un dato me avisas" (mas eficiente)
]

#importante[
  IDT (Interrupt Descriptor Table): tabla que contiene punteros a todas las rutinas de atencion de interrupcion. Las primeras 32 son excepciones, solo 20 estan en uso actualmente.
]

#nota[
  El flag IF controla si se atienden interrupciones externas:
  - IF = 1: habilitado (`sti` - set interrupts)
  - IF = 0: deshabilitado (`cli` - clear interrupts)
]

== Tipos de Interrupciones

#importante[
  - NMI (Non-Maskable Interrupt): no pueden ser enmascaradas, son criticas
  - IMR (Interrupt Mask Register): interrupciones normales que pueden ser enmascaradas
  - Ejemplo: teclado y mouse son interrupciones normales
]

== Excepciones

#nota[
  Tipos de excepciones:
  1. Faults: pueden corregirse, se guarda la direccion de la instruccion
  2. Trap: se usan para acceder al sistema operativo
  3. Abort: errores severos, no siempre se puede obtener la instruccion
]

#importante[
  Excepciones comunes:
  - Divide error
  - Invalid opcode
  - Stack exception
  - General protection (la pantalla azul)
  - Page fault
]

= Modo Protegido y MMU

#importante[
  La MMU (Memory Management Unit) es un metodo de interposicion que checkea cada acceso a memoria.

  Flujo:
  Direcciones logicas $->$ Unidad de segmentacion $->$ Direccion Lineal $->$ Unidad de paginacion $->$ Direccion fisica $->$ Memoria fisica
]

#tip[
  Memoria virtual: el procesador siempre da memoria, nunca dice que no hay mas. Es una abstraccion sobre la memoria fisica. Cuando accedes a 2000h, probablemente estes accediendo fisicamente a otro lado.
]

= Decodificacion

#importante[
  El pin IO/Mem del microprocesador:
  - Selecciona si escribir en memoria o en el mapa de I/O
  - Tiene corriente (True) si hay que escribir en el mapa de I/O
]

#importante[
  El pin R/W indica si se esta leyendo o escribiendo.
  - El pin de *READ* va enchufado tanto en la *RAM* como en la *ROM*
  - El pin de *WRITE* va enchufado solo en la *RAM*, si lo enchufas en la ROM
    es incorrecto (en parciales bajan puntos)
]

#tip[
  Se pueden dejar entradas de decodificadores sin enchufar, pero puede haber ruido. Solucion: conectar las entradas a ground (0).
]

== Intel vs Genericos

#nota[
  Diferencias entre procesadores Intel y genericos:

  Intel:
  - Tienen parte baja y alta en registros
  - Siempre dividen la memoria en bytes

  Genericos:
  - No tienen "parte baja y alta"
  - Siempre tratan todo como tamano de bus. Esto quiere decir que cada 
    "renglon" es una direccion de memoria independientemente del tamaño del
    bus
]

= Optimizaciones y Performance

#tip[
  Para determinar si multiples syscalls vs una sola syscall es mas eficiente, hacer profiling en ambos casos. La diferencia generalmente no es notable.
]

#tip[
  La convencion de backup de registros depende de cada caso. Si el sistema necesita optimizaciones, es preferible evitarlo.
]

#importante[
  Cuando se hace `sub esp, 32`, se estan restando 32 bytes. Siempre usar parametros de 4 bytes en programacion de 32 bits.
]

= Herramientas Utiles

== Links de Referencia

- `strace`: herramienta para interceptar system calls
- Godbolt (godbolt.org): pasaje en vivo de C a ASM
- NASM docs: directivas para reservar memoria y declarar datos
- Arquitectura PC Intel: stanislavs.org/helppc/

== Comandos Importantes

#tip[
  Para ver syscalls en Linux:
  ```bash
  strace ./programa
  ```
]

#tip[
  Verificar compilacion de C a ASM en tiempo real usando Godbolt para entender como el compilador traduce tu codigo.
]

= Notas Finales

#importante[
  Practica haciendo seguimiento de la pila en papel. Esto ayuda a visualizar el estado de la memoria y evitar errores comunes.
]

#tip[
  Si hay dudas sobre como el compilador traduce codigo C a ASM, usar Godbolt
]

