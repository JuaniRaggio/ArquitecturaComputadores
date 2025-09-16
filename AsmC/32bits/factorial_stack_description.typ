= Ejercicio - factorial

Sea la siguiente funcion escrita en C para un procesador con x86

```c
int factorial(int n) {
  int aux, fact;

  if (n == 0)
    return 1;

  aux = n;
  fact = factorial(n - 1);
  return fact * aux;
}
```

- Mostrar el estado de la pila si es invocado con n = 3.

=== Pre aux

#table(columns: 2)[???][][???][sub esp, 8][$"ret"_"main"$][][n][Primer parametro de la funcion]

=== Post aux

#table(columns: 2)[???][][\[ebp + 8\] = n][sub esp, 8][$"ret"_"main"$][][n][Primer parametro de la funcion]

=== Luego

#table(columns: 2)[add esp, 8 + mov esp, ebp][Limpio las dos variables locales, despues con el desarmado de stack frame][][call factorial][push "\[ebp + 8\] - 1"][Para dejar el n - 1 para el llamado a la funcion, pero es una copia en otro registro, no se pasa directamente \[ebp + 8\]][\[ebp + 8\] = n][][???][sub esp, 8][$"ret"_"main"$][][n][Primer parametro de la funcion]

\
\
\
\
\
\
\
\

#set page(columns: 2)
#place(
  top + center,
  scope: "parent",
  float: true,
  text()[
= Pila luego de haber invocado de factorial con n = 3
  ],
)

#align(center)[== Pre-retorno]

#align(center)[#table(columns: 1)[fact = ???][aux = ???][$"ebp"_"factorial(1)"$][$"ret"_"factorial(1)"$][1 - 1 = 0][fact = ???][aux = 1][$"ebp"_"factorial(2)"$][$"ret"_"factorial(2)"$][2 - 1 = 1][fact = ???][aux = 2][$"ebp"_"factorial(3)"$][$"ret"_"factorial(3)"$][3 - 1 = 2][fact = ???][aux = 3][$"ebp"_"main"$][$"ret"_"main"$][n = 3]]

#colbreak()

#align(center)[== Post-retorno]

#align(center)[#table(columns: 1)[fact = ???][aux = ???][$"ebp"_"factorial(1)"$][$"ret"_"factorial(1)"$][1 - 1 = 0][fact = 1][aux = 1][$"ebp"_"factorial(2)"$][$"ret"_"factorial(2)"$][2 - 1 = 1][fact = 1][aux = 2][$"ebp"_"factorial(3)"$][$"ret"_"factorial(3)"$][3 - 1 = 2][fact = 2][aux = 3][$"ebp"_"main"$][$"ret"_"main"$][n = 3]]
