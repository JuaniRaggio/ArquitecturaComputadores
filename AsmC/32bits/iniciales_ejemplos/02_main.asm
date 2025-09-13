;; main.asm

global main
extern puts, sprintf

section .rodata
fmt db "%d", 0
number dd 123456790

section .text

main:
;;; La signature de la funcion sprintf:
;;; int sprintf(char *str, const char *fmt, ...;)
        push dword [number]     ; primero pasamos los argumentos variables
        push fmt                ; luego el const char *
        push buffer             ; luego el char *
        call sprintf

        add esp, 3*4

        push buffer
        call puts

        add esp, 4
        ret

section .bss
        buffer resb 40
