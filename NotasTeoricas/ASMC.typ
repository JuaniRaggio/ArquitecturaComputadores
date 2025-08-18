#align(center)[= ASM y C]

Combinacion de dos lenguajes de programacion

- ASM es de mas bajo nivel, mientras que C esta estandarizado para cualquier arquitectura

- C se va a adaptar a ASM

= Repaso de Pila - Instrucciones

El stack pointer register o extended stack pointer *apunta al tope* de la pila, es decir al ultimo elemento.

Cuando se almacena un nuevo valor en la pila con *PUSH* el valor del puntero se actualiza para siempre apuntar al tope de la pila


== PUSH ...
_Que pasa cuando se ejecuta esta instruccion?_

- El procesador decrementa el registro *ESP* o *RSP*

- Guarda el valor en el stack

== POP ...
_Que pasa cuando se ejecuta esta instruccion?_

- Si el registro es de *un byte* (ej: AH), el *ESP* o *RSP* disminuye *solo un byte*

- Si el registro es de *cuatro bytes* (ej: ECX), el *ESP* o *RSP* disminuye *cuatro bytes*

- La *informacion queda intacta* despues de hacer el POP

Entonces el *POP* corre lo que puede almacenar el registro que le pasas

=== _Analisis forence de memoria_

- Copias la RAM despues de que un usuario use su computadora

- *TODA* la informacion queda en la memoria

== RET
_Que pasa cuando se ejecuta esta instruccion?_

- El procesador toma el contenido de lo apuntado por *ESP* (Lo guardado en la pila)

- Salta a esa posicion de memoria


#align(center)[= Pasaje de argumentos en C]

- Segun la arquitectura, se pasa de manera diferente

- Arq - *32 bits*
  + Se pasan por la _pila_

- Arq - *64 bits*
  + Se pasan primero por registros y luego por la pila

=== Porque se usan registros en vez de pila?

*Evitas inyeccion de codigo*

Si te pasan en un parametro _codigo_ en vez de lo que uno espera, estas *pusheando codigo al stack* y en la *RAM se puede ejecutar codigo*

=== De que esta formado un binario?

- Codigo

- Dato

- *SOLO CUANDO SE EJECUTA* se le asigna una pila

---

== Llamados a funciones con pila

- En x86, en el llamado a funciones la pila juega un rol fundamental

- Se almacenan *variables locales* de la funcion llamada, *sus argumentos* y su *direccion de retorno*

- Aparace el concepto de *frame*

#table(columns: 2)[*FUNCTION_C frame*][#table(columns: 1)[Variables locales de func_c][direccion de retorno][parametros de func_c]][*FUNCTION_B frame*][#table(columns: 1)[Variables locales de func_b][direccion de retorno][parametros de func_b]][*FUNCTION_A frame*][#table(columns: 1)[variables locales de func_a][direccion de retorno][parametros de func_a]]

_Nota_: Cada frame es parte de la pila que estaria ocupada por cada funcion. *ESP* va a apuntar a lo mas alto de la pila

_Nota 2_: Los stacks de diferentes funciones se van apilando uno arriba del otro


= Claves

- Todas las posiciones de memoria de Intel ocupan 1 Byte

- Estandarizacion de espacio para *eficiencia de acceso* a coste de *espacio*

