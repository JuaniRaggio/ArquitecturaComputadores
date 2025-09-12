;;; Este ejercicio parece ser una boludez la verdad, ni idea
section .text
        global _start
_start:
        call main               ; Suponiendo que main me deja el ret en eax
;;; _start no hace ret, sino que tiene que hacer el sys_exit
        mov ebx, eax
        mov eax, 1
        int 80h
