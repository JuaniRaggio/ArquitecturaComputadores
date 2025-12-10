= Memoria virtual

= Paginacion

- Divide a la memoria en tamaños fijos (vamos a usar $4k$ que era el standard
  viejo)

- Si un proceso te pide N Megas, se lo devolves en M Paginas, donde todas las
  *Paginas empiezan en multiplos de Paginas*

- *Reducimos la fragmentacion de memoria*

- Genera mapeo Pagina virtual $->$ Pagina Fisica (marcos)

\

== Me dicen:
_Quiero que hagas un mapeo de $2^20 " a " 2^18$_

*Quiere decir que tenes 2^20 virtuales, 2^18 fisicas*

\

= Resumen

Los ejercicios de paginacion son todos iguales, tenemos siempre:

- Mapa virtual $->$ Su tamaño depende del bus de address del procesador

- Mapa fisico $->$ Su tamaño depende de la cantidad de RAM que tengas

- Dentro del mapa fisico van a estar las tablas de mapeo (Dir + TP)

- Zona de mapeo -> Aca tenemos las tablas:

  - Directorio -> En el registro *CR3* vamos a tener la posicion de la tabla
    de directorio. Dentro de la misma, el ultimo bit (llamado p) nos va a
    decir si esta en memoria o no (Esta en RAM o en Disco)

  - Tabla de paginas -> Dentro de la misma, el ultimo bit (llamado p) nos va
    a decir si esta en memoria o no (Esta en RAM o en Disco)

\

= Atencion

- No poner CR3 (Posicion del directorio) en el mismo lugar que una pagina o 
  algo que lo pueda sobreescribir

