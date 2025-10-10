= Dudas

== Stack

- [X] El Canary si *no esta explicito en el .asm*
  En tal caso, no se agrega a la pila. El unico caso en el que tenemos que 
  agregarlo sin que este explicito es cuando nos pasan un codigo de C, en una
  funcion que contiene buffer y no compilan con el flag que evita la 
  proteccion de stack

== Eficiencia

- [X] Es ineficiente hacer muchas llamadas a syscalls?
  Es decir, si tengo un arreglo para printear, deberia hacer una syscall por cada item en el arreglo?
  Entiendo que si es una sola syscall, quiere decir que tengo que guardar espacio suficiente para que me entre el arreglo entero, que seria tener mucho espacio en simultaneo, pero igualmente quiero saber hasta que punto eso es una desventaja contra hacer syscall una por una

_La diferencia no es notable, en caso de encontrarme en una situacion asi, lo mejor seria correr ambas opciones y hacer el profiler_
_Me siguen diciendo que no, sera que es cierto_


== Compresion de archivos

- [X] _Como funciona la compresion de archivos?_
  - Muchisimo texto

== Decodificacion

- [X] _El mapa de I/O, es el mismo que el 'normal'?_
  - No.
  - Ocupa las mismas direcciones de memoria, pero no es el mismo
  - Hay que usar el pin del Microprocesador *IO/Mem* para elegir si escribir en
    memoria o en el mapa de entrada y salida. Hay corriente *(True) si hay que 
    escribir en el mapa de IO*

- [X] _Como se si se esta escribiendo o leyendo?_
  - Se usa el pin *R/W*

- [X] _Se pueden dejar entradas de decodificadores sin enchufar?_
  - Si
  - El problema que puede traer es que haya ruido/interferencia
  - Se resuelve conectando las entradas a *ground*, esto nos genera un 0 en la
    entrada, por lo que no habria ambiguedad del valor que tendriamos en la
    misma. Graficamente, puede representarse con el siguiente simbolo:
#align(center)[```sh
  |  
  |
  |  
-----
 ---
  -
"gnd"
```]

- [X] _Cual es la diferencia entre un procesador Intel y uno generico?_
  Muy basicamente:

  - Los procesadores Intel tienen parte baja y alta, ademas
    siempre dividen la memoria en bytes

  - Los procesadores genericos no tienen "parte baja y alta", sino que 
    siempre tratan todo como 'tamaño de bus'

- [X] En caso de tener un procesador Intel de BD = 16, pero tengo una RAM
  que tiene un _ancho de 8 bits_, podria poner una cantidad impar de las
  mismas? por ejemplo 1

  - Siento que tiene sentido que se pueda porque al poder tratar con parte
    baja y parte alta, podrias decirle al programador que la parte alta o
    baja no es accesible y que solo use AH o AL

== Paginacion y manejo de memoria

- [X] Si comprimis un archivo, el tamaño va a seguir siendo multiplo de una 
  pagina?
  _En el disco no se llaman páginas si o clusters. Y por más que comprimas todo es múltiplo de un clúster._

- [X] Dentro de la pagina, como se gestiona la memoria?

  - Mi duda viene principalmente por entender el funcionamiento de malloc
  _No hay gestion de memoria dentro de las paginas, simplemente accedes por el
  offset_


- [X] El registro CR3 me dice la direccion donde esta la tabla de directorio,
  pero la direccion virtual o la fisica?
    - *Fisica*

- [X] Pero le corresponde a las tablas tener una direccion virtual?
    - *Si*


