= x86_64 ABI
Hasta ahora trabajamos con la *ABI de 32 bits de C y Assembler*. Para la de 64 bits, los conceptos son los mismos, lo unico que cambia es el pasaje de parametros.

El pasaje de parametros se realiza de la siguiente forma:

- Se cargan los argumentos en los registros

- Se llama a la funcion

- Los argumentos se copian al stack y se referencia desde ahi

\

== Clasificacion de argumentos
Los argumentos se clasifican de la siguiente forma:

- *INTEGER:* char, short, int, long, long long y punteros

- *SSE*: floats y doubles

- *MEMORY*: datos mayores a un _quadword (8 bytes)_ y datos desalineados

\

== Pasaje de argumentos

- Si el dato es *INTEGER*, se van ocupando los registros:
  + rdi
  + rsi
  + rcx
  + r8
  + r9

- Si el dato es *SSE*, se van ocupando los registros:
  + xmm0
  + xmm1
  + ...
  + xmm7

- Si el dato es *MEMORY*, se pasan por stack y devuelven por stack (en el mismo orden que en 32 bits)

\

== Retorno de valores
Para devolver valores:

- Si el dato es *INTEGER*, se utilizan:
  - rax
  - rdx

- Si el dato es *SSE*, se retorna por:
  - xmm0
  - xmm1

== Registros a preservar

- rbp
- rsp
- rbx
- r12
- r13
- r15


