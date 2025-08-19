_start
;; Inicio del programa

section .text
;; Seccion No Editable
;; Seccion Ejecutable
    mov edx, length
    mov ecx, to_print
    call print

.print
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
    to_print "Hello world!", 10

    ;; Forma de definir una variable, se usa la keyword: equ
    length equ $ - to_print

section .bss
    placeholder resb 10

