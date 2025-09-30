        section .bss
        buffer resb 13
        section .rodata
        STDOUT  equ 1
        section .text
        global  _start
;;; La funcion cpuid brinda informacion del procesador en los registros:
;;; eax
;;; ebx
;;; ecx
;;; edx
;;; La informacion brindada en cada registro depende de el contenido de eax
_start:
        xor     eax, eax
        cpuid   ; Deja en ebx, edx, ecx la informacion del fabricante
        mov     [buffer],       ebx
        mov     [buffer + 4],   edx
        mov     [buffer + 8],   ecx
        mov     byte [buffer + 12],  10

        mov     eax, 4
        mov     ebx, STDOUT
        mov     ecx, buffer
        mov     edx, 13
        int     80h
        mov     eax, 1
        mov     ebx, 0
        int     80h
