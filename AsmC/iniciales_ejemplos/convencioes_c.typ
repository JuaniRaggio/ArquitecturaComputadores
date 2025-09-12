= Llamadas de Assembler a C
Este camino es el más fácil de entender. Si recordamos que al final de cuentas, una función en C es una dirección de memoria, no debería ser difícil hacer una llamada desde ASM a C. Vamos a utilizar el programa nasm para compilar los archivos en asm, gcc para compilar los archivos en C y también para linkeditarlos entre sí y contra la biblioteca estándar de C

\

== Como compilar y correr archivos en asm + c?

```sh

nasm -f elf32 main.asm

gcc -c -m32 hello.c

gcc -m32 main.o hello.o -o hello

./hello

```

La directiva *-f elf32* le indica a nasm que genere un archivo objeto con formato elf (executable linux format) para una arquitectura de 32 bits. Algo equivalente hace la directiva -m32. _Si no se especifica esto, el formato default es el de la máquina actual._

== Pregunta:
  Ya que ahora estamos en un entorno de C. De que otra forma se podria haber terminado el programa?
  - Con exit(1); desde C

\

= Ejemplo 2
- En este ejemplo vamos a pasar un valor a su representacion en ASCII 
numerica.
- Recordemos que la convencion en C de pasaje de parametros es por Stack en
32 bits

La funcion de C sprintf escribe un string con formato en un stream, tiene el siguiente prototipo:

```c
int sprintf(char * str, const char * fmt, ...);
```

Entonces para llamar a la funcion primero se pushean al stack los argumentos variables, despues la cadena *fmt* y por ultimo *str*

```c
int puts(const char * str);
```

\

== Preguntas

1. Porqué se le suma al stack, luego de llamar a la función sprintf, 12 bytes? ¿Porqué se hace lo mismo luego de llamar a puts?

  - Para pisar la informacion del stack que ya no usa
  - Lo mismo pero suma solo 4 porque solo se pusheo al stack un buffer que es dd (double word -> 2 * word -> 2 * 2 bytes)

2. Cual es el valor de retorno de la funcion main?

  - void(?

\

= Registros a preservar entre llamadas

Entre llamadas de C, hay ciertos registros que las funciones deben preservar para no afectar el funcionamiento de otras funciones. Las funciones que llaman deben tener en cuenta que registros pueden cambiar, de tal forma de hacer un backup antes de llamarlas.

- ebx
- esi
- edi
- ebp
- esp

Es decir, cuando una funcion termina, *debe dejar exactamente los registros anteriores como los recibio*

\

= Stack Frame

Es parte de la ABI de C, cuando se entra a una funcion, se arma esta estructura.

\

= Alineamiento a palabra
El procesador cada vez que accede a memoria, lo hace *leyendo y escribiendo siempre 4 bytes*

- Cuando el procesador accede a un *dato desalineado*, debe hacer *dos lecturas*, una para pedir la primer porcion de los datos, y otra para la segunda porcion

- Para la escritura requiere mas operaciones, debe:

  + Leer memoria para salvar el dato que no va a sobreescribir
  + Combinarlo con el dato que si va a escribir para la primera porcion
  + Recuperar el dato de la segunda porcion para escribir la segunda porcion


Una forma facil de arreglar este problema, es negar los ultimos 4 bits. Como el stack crece hacia menores valores de esp, seguro esa posicion va a estar por detras del puntero actual. De esta forma se puede hacer un acceso a memoria mas eficiente


```yasm

GLOBAL main
ALIGN 4
main:
  push ebp
  mov ebp, esp
  ;declaración de variables
  and esp, -16
  ;... programa
  mov esp, ebp
  pop ebp
  ret

```

La representacion de -16 en hexadecimal es: *0xFFFFFFF0* (en 32 bits)

\

= GOT - Global Offset Table
Es una tabla en memoria (sección especial del binario) que guarda direcciones absolutas de variables y funciones globales cuando un programa está compilado en modo PIC/PIE (Position Independent Code/Executable).


= PLT - Procedure Linkage Table
_Es como un cacheo de funciones, una vez llamaste a una funcion, la proxima vez que la llames va a ser mas rapido porque ya esta guardada en el GOT_

- Sirve para llamadas a funciones externas
- Usa el GOT como apoyo:
  - Cada entrada del PLT tiene un salto indirecto a una direccion guardada en el GOT
  - La *primera vez* que llamas a printf, el PLT pasa por el *resolver* que busca printf en las librerias dinamicas y *escribe la direccion real en el GOT*
  - *Desde la segunda llamada*, se *salta directamente* a la direccion guardada -> *mucho mas rapido*







