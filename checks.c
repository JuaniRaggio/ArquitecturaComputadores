#include <stdio.h>

void recibo_vec(char * vec);

struct prueba_alineamiento_struct {
    // int a2;
    long a7;
    char a1;
    char a3;
    char a4;
    char a5;
    char a6;
};

int main(void) {
  char * var = "Hola";
  printf("%s\n", var);
  printf("%lu", sizeof(double));
  printf("%lu", sizeof(int));
  char frases[] = "Buen dia";
  recibo_vec(frases);
}

void recibo_vec(char * vec) {
  vec = vec + 1;
}

void struct_sizes() {
  printf("%lu\n", sizeof(int));
  printf("%lu\n", sizeof(long));
  printf("%lu\n", sizeof(struct prueba_alineamiento_struct));
}

