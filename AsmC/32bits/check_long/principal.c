#include <stdio.h>
#include <assert.h>

extern int check_long(char * vector, int length);

int main(void) {

    // Check correctos
    assert(0 == check_long("Hello world!", 12));
    assert(0 == check_long("", 0));

    // Check incorrecto (parametro menor por 1)

    assert(1 == check_long("Hello world!", 11));

    // Check incorrecto (parametro mayor por 1)
    assert(-1 == check_long("Hello world!", 13));

    printf("OK!\n");
}
