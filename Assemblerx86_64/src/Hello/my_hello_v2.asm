section .text
;; Seccion No Editable
;; Seccion Ejecutable

;; Si o si hay que poner GLOBAL _start
;; porque sino no encuentra el _start y hace un default
;; que seria comportamiento "indefinido"
GLOBAL _start

_start:
    ;; Inicio del programa
    mov edx, length
    mov ecx, to_print
    call print
    mov eax, 1
    mov ebx, 0
    int 80h

;; duda / doubt
;; Cual seria la diferencia entre hacer esta declaracion:
;; .print:
;; y la que hice en el codigo?
print:
    ;; Funcion que pertenece a la seccion .text
    push ebp
    mov ebp, esp
    mov eax, 4 ;; Syscall ID de write: 4
    mov ebx, 1 ;; stdout
    int 80h
    mov esp, ebp
    pop ebp
    ret


section .data
;; Seccion Editable
;; Seccion No Ejecutable

    ;; Necesitamos pasarle el codigo int que representa
    ;; el ASCII del \n (New line)
    to_print db "Hello world!", 10

    ;; Forma de definir una variable, se usa la keyword: equ
    length equ $ - to_print

section .bss
    placeholder resb 10

