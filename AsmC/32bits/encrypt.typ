= Ejercicio 14 - encrypt

```c

void encrypt(char *plain, char *cipher){
    if(!(*plain)){
        *cipher = 0;
        return;
    }

    char pad = get_pad();
    *cipher = *plain + pad;
    encrypt(plain+1, cipher+1);
}

void test(){
    char *msg = “Ark”;
    char cipher[] = “--------”;
    cipher[4] = ‘0’;
    encrypt(msg, cipher);
    printf(cipher);
}

```

- Suponga que el dispositivo de encriptacion comienza devolviendo 1 byte igual a 0 e incrementa en 1 en cada llamada.

  _Esto quiere decir que get_pad() empieza devolviendo 0 y va incrementando en cada llamado_

- Muestre como cada operacion altera el estado de la pila al invocar la funcion test y cual es la salida por salida estandar

#table(columns: 2)[`char *msg = "Ark";`][sub esp, 8 (se "agregan espacios con basura" a la pila para variables locales)][`encrypt(msg, cipher)`][Los parametros ya estan en el stack, por lo que podria hacerse directo el call si se colocan correctamente los parametros en el stack.][`void encrypt(char * plain, char * cipher)`][Armado de stack frame][][Reserva para variables locales dentro de encrypt (*sub esp, 1* (solo hay una y es un char))][`get_pad();`][Armado de stack frame por si es necesario usar el stack dentro de `get_pad()`][`*cipher = *plain + pad;`][Acceso con \[ebp + 8\] al primer parametro][][Acceso con \[ebp + 12\] al segundo parametro (`*cipher`)][][Se pisa lo que habia en el valor derecho del primer parametro con lo que corresponde][`encrypt(plain + 1, cipher + 1)`][Para enviar estos parametros se accede a ebp + 8 y ebp + 12 (plain y cipher respectivamente)][(_En el scope de ecrypt_ aunque no tenga sentido hablar de scope si hablamos de stack), luego del llamado a encrypt, debe hacerse una limpieza del stack para dejarlo igual que cuando se llamo a esta funcion.][Entonces deberia hacerse un *`add esp, 1`* (se habia reservado solo un byte para pad)][`printf(cipher)`][push cipher + call printf][][Armado de stack frame para printf][][Cosas de printf][Luego de llamar a printf][Se debe hacer un *`add esp, 8`* para limpiar el stack y dejarlo como estaba antes de llamar a la funcion `test()`]

- Encuentra algun error posible en todo el codigo anterior?

  _Si_, en caso de que no haya una *terminacion en null*, vamos a obtener un *StackOverflow* error, porque la funcion va a seguir apilando:

  + Espacio para variables locales
  + Armados de stack frame (ebp s)

  y como nunca llega a limpiar los stacks "locales" de cada funcion porque se queda esperando al retorno del llamado a la funcion del siguiente caso, va a hacer esto *"infinitamente" y eso implica pisar la pila, lo cual es terrible* (en su defecto, en algun momento de la memoria, podriamos encotrar un null asique podria pasar y que tengamos la "suerte" de salir, lo cual seria peor porque estariamos pisando memoria sin darnos cuenta)

=== Uso de Canary

Para evitar este problema, se le da lugar al canary que evita que se pise memoria

