= Tips - Claves - Arquitectura de computadoras

- Todas las posiciones de memoria de Intel ocupan 1 Byte

- Estandarizacion de espacio para *eficiencia de acceso* a coste de *espacio*

- Armado y desarmado de stack frame

- La convencion de backup de registros o no depende de cada uno y si el sistema necesita optimizaciones, es preferible evitarlo

- Accesso a letra dentro de un string, *usar registros de 8 bits*

= Size de lo que se quiere operar

Es importante aclarar el size de la cantidad de bytes con los que se quiere operar cuando hablamos de punteros

_Las opciones son:_

- byte $->$ 1 byte

- word $->$ 2 bytes

- dword $->$ 4 bytes

- qword $->$ 8 bytes

