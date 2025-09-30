= Ejercicio 5 - Guia 3

Encontrar las diferencias de declarar las variables y utilizarlas de las siguientes formas:

1. Variable local, en assembler solo se va a reservar espacio, haciendo un sub esp, 16
```c
// variables1.c

int foo() {
  int numero;
}

```

2. Variable local, en assembler se va a reservar espacio primero y luego se le va a asignar a ese espacio el valor 21
```c
// variables2.c

int foo() {
  int numero = 21;
}

```

3. Variable global, se reserva espacio desde bss, por lo que se tiene acceso desde cualquier lado. Luego desde dentro de la funcion, se le asigna 21
```c
// variables3.c

int numero;

int foo() {
  numero = 21;
}

```

4. Variable global, probablemente aca si se reserva espacio desde data ya que solo se va a reservar espacio una sola vez (en tiempo de compilacion) pero se va a poder modificar desde el scope de la funcion
```c

int foo() {
  static int numero = 21;
}

```

5. Variable global definida en otro archivo, desde adentro de la funcion simplemente se modifica la direccion de memoria en donde se guardo espacio para esa variable (se mueven solo dword, es decir, 4 bytes en caso de estar en 32 bits)
```c

extern int numero;

int foo() {
  numero = 10;
}

```

