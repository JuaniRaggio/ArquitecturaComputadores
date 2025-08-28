section .text ;; Codigo

global _start

_start:
    ;; ...
    call num2str
    ;; ...

.exit:
    mov eax, 1
    mov ebx, 0
    int 80h

section .data ;; Datos

section .bss ;; Better Save Space

