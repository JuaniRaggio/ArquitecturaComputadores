= Llamadas de Assembler a C
Este camino es el más fácil de entender. Si recordamos que al final de cuentas, una función en C es una dirección de memoria, no debería ser difícil hacer una llamada desde ASM a C. Vamos a utilizar el programa nasm para compilar los archivos en asm, gcc para compilar los archivos en C y también para linkeditarlos entre sí y contra la biblioteca estándar de C


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

== Preguntas

1. Porqué se le suma al stack, luego de llamar a la función sprintf, 12 bytes? ¿Porqué se hace lo mismo luego de llamar a puts?

  - Para pisar la informacion del stack que ya no usa
  - Lo mismo pero suma solo 4 porque solo se pusheo al stack un buffer que es dd (double word -> 2 * word -> 2 * 2 bytes)

2. Cual es el valor de retorno de la funcion main?

  - void(?


= Registros a preservar entre llamadas

Entre llamadas de C, hay ciertos registros que las funciones deben preservar para no afectar el funcionamiento de otras funciones. Las funciones que llaman deben tener en cuenta que registros pueden cambiar, de tal forma de hacer un backup antes de llamarlas.

- ebx
- esi
- edi
- ebp
- esp

Es decir, cuando una funcion termina, *debe dejar exactamente los registros anteriores como los recibio*


= Stack Frame

Es parte de la ABI de C, cuando se entra a una funcion, se arma esta estructura.


