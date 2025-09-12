;;; siete.asm
        global siete
        section .rodata
        seven equ 7
        section .text
siete:
        mov eax, seven
        ret
