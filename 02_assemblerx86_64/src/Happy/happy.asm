section .text

global _start

_start:
    ;; Armado de stack frame
    push ebp
    mov ebp, esp
    mov edx, msg ;; Guardo char *

;; Registro de 8 bits para letras
loop:
    call to_lowercase ;; Chequear si la letra es minuscula primero
not_lower_case:
    inc edx
    mov eax, edx ;; Guardo la posicion actual en registro auxiliar
    sub eax, msg
    cmp eax, length ;; Si el puntero esta en length
    je .print ;; Saltamos a print pq ya finalizo el string
    jmp loop ;; Si no, seguimos en el loop

.print: ;; Write syscall
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, length
    int 80h
    ret

.end: ;; Exit with code 0 -> No hubo problemas
    mov eax, 1
    mov ebx, 0
    int 80h
    ret

to_lowercase:
    mov al, [edx]
    cmp al, 'a'
    jl not_lower_case
    cmp al, 'z'
    jg not_lower_case
    sub byte [edx], to_uppercase_gap ;; tug no necesita corchetes porque es una constante
    ret

section .data
    msg db "h4ppy c0d1ng", 10, 0
    length equ $ - msg
    to_uppercase_gap equ 'a' - 'A'

section .bss
    buffer resb 1024

