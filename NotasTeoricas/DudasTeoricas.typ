= Dudas

== Memoria

- [ ] Cuando se hace:

```asm
mov al, 0
mov eax, 0
```

Es decir, si solo me interesa la parte baja pero complica mucho mas el codigo. Hay una diferencia significativa?

== Eficiencia

- Es ineficiente hacer muchas llamadas a syscalls?
  Es decir, si tengo un arreglo para printear, deberia hacer una syscall por cada item en el arreglo?
  Entiendo que si es una sola syscall, quiere decir que tengo que guardar espacio suficiente para que me entre el arreglo entero, que seria tener mucho espacio en simultaneo, pero igualmente quiero saber hasta que punto eso es una desventaja contra hacer syscall una por una

