= Assembler

- No olvidarse de hacer la estructura correcta, el *int 80h* es muy olvidable

```yasm

;; Syscall
;; ...
int 80h

```

- Hacer la syscall de exit me permite no tener que hacer un armado y desarmado de stack frame en la funcion \_start

