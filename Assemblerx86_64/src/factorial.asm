section .text

global factorial

;; Dado un número n, imprimir su factorial.
;; Tenga cuidado con los argumentos de la función.
;; Recibo @n por stack
factorial:
    ;; Armado de stackframe
    push ebp
    mov ebp, esp

    ;; Guardo copia del @n en el eax (registro de salida por convencion de C)
    mov eax, [ebp + 8]
    ;; Guardo copia de la copia, para usar de multiplicador
    mov ebx, eax
    dec ebx

.multiplication_loop:
    mul ebx
    dec ebx
    jnz .multiplication_loop

.print_number:
    

section .data

section .bss
    buffer resb 32

