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


= Registros que se preservan:

- edx
- esi
- edi
- ebp
- esp

= Paginacion

== Que pasa si me piden de 64 bits?

- Es lo mismo, lo que cambia es el ancho

- $"Lo que ocupa una pagina" - 1 ->$ tiene que ser el valor maximo obtenido
  con todos los bits del offset encendidos en 1


- Su sistema de 64 bits necesita 2MB

- Paginas alineadas a 2MB $->$ necesitas si o si 21 bits para offset porque
  sino no podes llegar al final de la pagina

