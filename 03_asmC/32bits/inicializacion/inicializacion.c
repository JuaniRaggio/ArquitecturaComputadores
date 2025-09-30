// Inicializacion en una etiqueta global con dw
int numeros_globales_sin_inicializar[20];

// Idem pero con inicializacion en tiempo de ejecucion o que el ptr este
// apuntando a una zona ya cargada de ceros
int numeros_globales_inicializados[20] = {0};


// En caso de compilar esta funcion directo, probablemente se reserve espacio
// para TODOS los punteros y despues se haga el acceso a los indices a los
// que se desee acceder
void inicializacion_arreglos() {

// Esta inicializacion va a ser estandar, probablemente se reserven 20 * 4 
// bytes y quizas un poco mas
    int numeros_sin_inicializar[20];

// En este caso yo creo que va a pasar lo mismo y se llena de ceros en tiempo
// de compilacion.
// Opcion 2 seria que ya haya una zona de memoria llena de ceros y sea un
// puntero apuntando alli
    int numeros_en_cero[20] = {0};

// Este caso igual al primero y luego se va a cargar el 69
    int numeros_a_inicializar[20];
    numeros_a_inicializar[10] = 69;

}
