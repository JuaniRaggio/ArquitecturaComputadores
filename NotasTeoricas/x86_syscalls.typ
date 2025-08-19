= x86_64 System calls

- Herramienta para interceptar las system calls hechas por un programa 
a la hora de ejecutarse: *strace*
_Uso:_

```bash

	strace ./hello

```

_Posible salida (en mi VM con un hello world):_

```bash
 
  execve("./hello", ["./hello"], 0x7ffc887cbc60 /* 24 vars */) = 0
  [ Process PID=12275 runs in 32 bit mode. ]
  write(1, "Hola Mundo!!\n", 13Hola Mundo!!) = 13
  exit(0) = ?
  +++ exited with 0 +++

```

\

= Secciones de un programa en assembler

- Datos (_section .data_)

- Codigo (_section .text_)

- .bss $->$ Better Save Space. No ocupa espacio en el binario pero es una seccion que se carga con ceros cuando se carga el programa en memoria

== _En realidad..._
La parte de data es la seccion "*editable pero no ejecutable*" del programa, mientras que la parte de text es la seccion "*no editable pero ejecutable*"

#table(columns: 4)[Descripcion][Nombre en Codigo asm][Ejecutable?][Editable][Datos][_section .data_][*No*][*Si*][Codigo][_section .text_][*Si*][*No*]

\

= System call IDs

- Todas las system calls tienen un ID que las representa

- El *system call ID* debe ser ingresado en el registro *EAX* (? (Preguntar)

= Links utiles

- #link("http://www.nasm.us/doc/nasmdoc3.html")[#underline[Directivas para reservar memoria, declarar datos y constantes]]

- #link("http://stanislavs.org/helppc/")[#underline[Arquitectura de una PC Intel]]

- #link("http://web.archive.org/web/20160213015253/http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html")[#underline[Para ver syscalls]].

