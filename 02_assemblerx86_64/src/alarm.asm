section .text

_start:
        mov eax, 0x1b
        mov ebx, 1
        int 80h
        mov eax, 1
        mov ebx, 0
        int 80h
