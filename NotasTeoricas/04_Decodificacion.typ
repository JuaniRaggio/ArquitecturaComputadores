#align(center)[= Decodificacion]
Se encuentra entre la CPU y la Memoria (ROM/RAM)

- Para conectar _mas de un dispositivo_ al procesador tenemos que hacer "decodificacion"

- Para hacer *decodificacion* necesitamos herramientas electronicas:

  - Compuertas

  - Decodificadores


- Mientras la PC esta prendida, funciona la RAM

- El disco es espacio extra para guardar informacion pero es *extremadamente lento*. Esa lentidud se la da la *persistencia*


= Compuerta

_Elemento fisico que hace el algebra de boole fisicamente -> Digitaliza el algebra de boole (las operaciones mas sencillas)_

- Vcc: Voltaje de corriente continua (positivo)

- GND: Ground

- Compuertas:

  - *NOT*

  - *OR*

  - *AND*

  - *NAND*: And y despues niego

  - *NOR*: Or y despues niego

  - *XOR*: Uno u otro pero no los dos

  - *BUFFER*: Devuelve lo mismo. Condiciones electronicas: Perfecciona el grafico de voltaje


= Ejercicio Decodificacion de ROM

Se dispone de un microprocesador con 16 lineas de bus de direcciones y 8 lineas de bus de datos.

Se desea conectar el procesador con dos integrados de ROM de $32 "K" times 8$


= Decodificadores

- 2 a 4 -> _*2 entradas y 4 salidas*_

- 3 a 8 -> _*3 entradas y 8 salidas*_

- 4 a 16 -> _*4 entradas y 16 salidas*_


== Decodificador n a t

- *n entradas*

- *t salidas*

- $t = 2^n$

== Chip select

Es el que se encarga de seleccionar *cual es el periferico* con el que vamos a operar.

==== Como lo hace?

- Tomamos los limites de los rangos de memoria

- Buscamos los digitos en comun que distinguen el rango que ocupa el periferico de las demas direcciones

- Metemos esas "patitas" de los digitos en comun mas significativos en el decodificador

\

= Ejercicio decodificacion de ROM
Se dispone de un microprocesador con 16 lineas de bus de direcciones y 8 lineas de bus de datos.

Se desea conectar el procesador dos integrados de ROM de $16"K" times 8$ a partir de la direccion de memoria 8000h

Siempre usar *decodificacion completa*, es decir usar todas las patitas

- 16 BA y 8 BD $=> 2^16 = 2^6 2^10 = 64"K"$

- Para sacar la mitad de 

