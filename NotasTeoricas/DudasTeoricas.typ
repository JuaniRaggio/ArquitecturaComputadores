= Dudas

== Memoria

- [ ] Cuando se hace:

```asm
mov al, 0
mov eax, 0
```

Es decir, si solo me interesa la parte baja pero complica mucho mas el codigo. Hay una diferencia significativa?


== Eficiencia

- Es ineficiente hacer muchas llamadas a syscalls?
  Es decir, si tengo un arreglo para printear, deberia hacer una syscall por cada item en el arreglo?
  Entiendo que si es una sola syscall, quiere decir que tengo que guardar espacio suficiente para que me entre el arreglo entero, que seria tener mucho espacio en simultaneo, pero igualmente quiero saber hasta que punto eso es una desventaja contra hacer syscall una por una

_La diferencia no es notable, en caso de encontrarme en una situacion asi, lo mejor seria correr ambas opciones y hacer el profiler_


== Compresion de archivos

- _Como funciona la compresion de archivos?_
  - Muchisimo texto

= Decodificacion

- _El mapa de I/O, es el mismo que el 'normal'?_
  - No.
  - Ocupa las mismas direcciones de memoria, pero no es el mismo
  - Hay que usar el pin del Microprocesador *IO/Mem* para elegir si escribir en
    memoria o en el mapa de entrada y salida. Hay corriente *(True) si hay que 
    escribir en el mapa de IO*

- _Se pueden dejar entradas de decodificadores sin enchufar?_
  - Si
  - El problema que puede traer es que haya ruido/interferencia
  - Se resuelve conectando las entradas a *GND* que graficamente, puede
    representarse con el siguiente simbolo:

    #align(center)[```sh
  |  
  |
  |  
-----
 ---
  -
"gnd"
```]

