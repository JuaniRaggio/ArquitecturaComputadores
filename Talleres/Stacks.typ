= Ejercicio de parcial (3 puntos)

```c
#include <stdio.h>

int suma(int a) {
  int operando = 9;
  return operando + a;
}

int main() {
  printf("Res = %d", suma(suma(10)));
  return 0;
}

```

1. Dibujo pila y registros

_32-bits_
#table(columns: 2)[operando 9][9) sub][\/\/\/\/\/\/\/\/\/\/][][_CANARY_][][ebp(main)][7) push; 10) mov esp, ebp][ret(main)][6) call; 11) pop ebp][10][5) push; 12) ret \/\/ eax = 19][\/\/\/\/\/\/\/\/\/\/][sub esp, N][_CANARY_][][][3) mov ebp, esp; 2) push ebp][ret(SO)][1)]

2. Valor de retorno

3. Mostrar salida

