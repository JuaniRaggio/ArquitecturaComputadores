// La idea de este ejercicio es armar el stack que se forma con esta funcion

#include <stdio.h>
int factorial (int n) {
        // Aca en asm se hace el armado de stack frame
        // Se reserva memoria para locales
        if (n == 0)
                return 1;
        int fact_n_1 = factorial(n - 1);
        return n * fact_n_1;
}
