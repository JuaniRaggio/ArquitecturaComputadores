#include <stdio.h>

// Esto es una prueba para ver la diferencia entre pasaje de structs por
// copia vs pasaje de structs por referencia

struct parametro {
    char caracter1;
    int numero1;
    char caracter2;
};

void recibidor_x_copia(struct parametro arg) {
    // printf("Copia probando acceso:\nCaracter1: %c\nNumero1: %d\nCaracter2: %c", arg.caracter1, arg.numero1, arg.caracter2);
}

void recibidor_x_referencia(struct parametro * arg) {
    // printf("Referencia probando acceso:\nCaracter1: %c\nNumero1: %d\nCaracter2: %c", arg->caracter1, arg->numero1, arg->caracter2);
}

int main(void) {
    struct parametro arg;
    recibidor_x_copia(arg);
    recibidor_x_referencia(&arg);
}

