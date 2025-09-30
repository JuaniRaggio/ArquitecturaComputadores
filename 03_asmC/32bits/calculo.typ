= Ejercicio 17 - Calculo

Dado el siguiente programa que se compila para un procesador de 32 bits:

```c

#include <stdio.h>

int calculo(int param1, int param2, char tipo) {
        int resul;

        if (tipo == 's')
          resul = param1 + param2;
        else
          resul = param1 * param2;

        return resul;
}

int main(void) {
        int valor1 = 7;
        int valor2 = 3;
        char operacion;

        printf("Ingrese tipo de operacion: 's' suma y 'm' multiplicacion:\n");
        scanf("%c", &operacion);
        printf("Resultado %d\n", calculo(valor1, valor2, operacion));
        return 0;
}


```

1. Explique con dibujos respectivos el contenido de la pila durante toda la ejecucion del programa

2. Muestre los registros del microprocesador que intervienen en los dibujos de la pila

#set page(columns: 2)

== Stack
#table(columns: 1)[*Ancho de renglon: 4 bytes*][|]["Resultado %d\\n"][valor de retorno de calculo][resul = valor1 'operacion' valor2][valor1 = 7][valor2 = 3][operacion = '...']["%c"][&operacion (scanf me deja en operacion lo que lee)]["Ingrese tipo de operacion...\\n"][Basura (3 bytes para alinear) | operacion = ???][valor2 = ???][valor1 = ???]

#colbreak()

== Registros
#table(columns: 1)[EAX][0][valor de retorno de calculo][valor de retorno de calculo][???][???][???][???][???][???][???][???][???][???][???]




