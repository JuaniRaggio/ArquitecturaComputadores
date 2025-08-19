section .text

GLOBAL _start

_start:
    push ebp
    mov ebp, esp
    ; En el programa ejemplo no se hace el armado de stack frame
    ; no hay que hacerlo siempre?

    ; Instrucciones de print
    ; En el link de system calls se encuentran todas estas instrucciones
    mov ecx, to_print ; En ecx va lo que queres imprimir
    mov edx, length ; En edx va la cantidad de bytes a imprimir en forma de size_t
    mov ebx, 1 ; En ebx va el file descriptor
    mov eax, 4 ; En eax va el syscall ID
    int 80h

    ; Instrucciones de exit
    mov eax, 1
    mov ebx, 0
    int 80h

section .data
    to_print db "Hello world!", 10
    length equ $ - to_print

; section .bss
;     placeholder resb 10
