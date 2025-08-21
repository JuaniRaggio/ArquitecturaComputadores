#align(center)[= ASM y C]

Combinacion de dos lenguajes de programacion

- ASM es de mas bajo nivel, mientras que C esta estandarizado para cualquier arquitectura

- C se va a adaptar a ASM

= Repaso de Pila - Instrucciones

El stack pointer register o extended stack pointer *apunta al tope* de la pila, es decir al ultimo elemento.

Cuando se almacena un nuevo valor en la pila con *PUSH* el valor del puntero se actualiza para siempre apuntar al tope de la pila

El *EBP* (base pointer) siempre es mayor o igual al *ESP*

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

== Convenciones en C

- Uso del registro *EBP* (base pointer)

- Para poder acceder a los parametros y no perder informacion en el proceso, tenemos que hacer un *armado y desarmado de stack frame*

\
\
\
\
\
\
\

=== Armado de stack frame

```asm
  push ebp
  mov ebp, esp
```

=== Desarmado de stack frame

```asm
  mov esp, ebp
  pop ebp
```

=== Acceso a parametros

```asm
  mov ax, [ebp + 8]
```

\

=== Importancia de dejar el stack como estaba

Cuando se llama a una funcion, es buena práctica, *dejar el estado del procesador
como se recibió*.

Considere un caso, donde hay un ciclo que compara con el flag
Z, que llama a una función, que lo altera.

```yasm
Ej:
  ...
  dec ecx
  call procesar	
  jz fin

fin:	
  ...
```

Suponiendo que *procesar* es una función que recibe por ecx un numero, (el del
contador, que se espera que llegue a 0) y resulta que *realiza operaciones que
cambian el flag Z*, un programador podría pasar inadverdido, y jamas terminar el
ciclo.

=== Valores a retornar

- Menor a 32 bits retorna en EAX

- Mayor a 32 bits retorna la parte alta de *EDX* y la parte baja en *EAX*

- Dato mas complejo (ej. Estructura de datos) *retorna un puntero formado por EDX:EAX*

== Llamada de C a ASM

```C

#include <stdio.h>

// La palabra extern esta para que el linkeditor 
// entienda que esta funcion no esta en este .c
// sino que en otro archivo

extern unsigned siete(void);

int main(void) {
  printf("Devuelve el numero siete = %d\n", siete());
  return 0;
}

```

```asm

[GLOBAL siete]
[SECTION .text]

siete:
  push ebp
  mov ebp, esp
  ...
  ...

```

== Inline Assembler
_Es una aberracion de la naturaleza_

```C

int main(void) {

#include <stdio.h>

int main() {
    int a = 10, b = 20, result;

    __asm__ (
        "movl %1, %%eax;"   // mueve 'a' a eax
        "addl %2, %%eax;"   // eax += b
        "movl %%eax, %0;"   // resultado en 'result'
        : "=r" (result)     // salida
        : "r" (a), "r" (b)  // entradas
        : "%eax"            // registros modificados
    );

    printf("Resultado: %d\n", result);
    return 0;
}

```


= Claves

- Todas las posiciones de memoria de Intel ocupan 1 Byte

- Estandarizacion de espacio para *eficiencia de acceso* a coste de *espacio*

- Armado y desarmado de stack frame

- La convencion de backup de registros o no depende de cada uno y si el sistema necesita optimizaciones, es preferible evitarlo

- Accesso a letra dentro de un string, *usar registros de 8 bits*

