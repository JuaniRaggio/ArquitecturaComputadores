;;; Este ejercicio parece ser una boludez la verdad, ni idea
section .text
        global _start
_start:

        ;; Armado de stack frame
        push ebp
        mov ebp, esp
        call main               ; Suponiendo que main me deja el ret en eax

        ;; Desarmado de stack frame
        mov esp, ebp
        pop ebp
        ret                     ; Puedo hacer directamente el ret sin mover
                                ; nada
