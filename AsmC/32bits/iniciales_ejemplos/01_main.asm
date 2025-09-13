;; main.asm

global main
extern hello_world

section .text

main:
        call hello_world

        mov eax, 1          ; syscall exit
        mov ebx, 0          ; exit code 0
        int 80h

