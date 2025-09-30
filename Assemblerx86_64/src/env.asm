section .text

global _start

_start:
        mov eax, 11
        mov ebx, shell
        mov ecx, argv           ; arreglo de argumentos
        mov edx, 0              ; environment (NULL)
        int 80h

section .data
        shell db "/bin/bash", 0
        flag db "-c", 0
        cmd db 'echo "$USER"', 0
        argv dd shell, flag, cmd, 0

