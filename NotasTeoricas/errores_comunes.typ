= Assembler

- No olvidarse de hacer la estructura correcta, el *int 80h* es muy olvidable

```yasm

;; Syscall
;; ...
int 80h

```

- Hacer la syscall de exit me permite no tener que hacer un armado y desarmado de stack frame en la funcion \_start

- Cuando se hace un mov y el destino queremos que sea el valor derecho de un puntero, es decir que usamos:

```yasm
  ;; ...
  mov byte [esi], 0
  ;; ...
```

*SI o SI AGREGAR LA CANTIDAD DE BYTES QUE QUEREMOS MOVER*
_En este caso seria un byte porque quiero que esi apunte a un string y estoy poniendo el 0 final_

