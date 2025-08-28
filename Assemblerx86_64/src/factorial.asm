section .text

global factorial

;; Dado un número n, imprimir su factorial.
;; Tenga cuidado con los argumentos de la función.
;; Recibo @n por stack
;; Si es negativo o 0, retorna 1

factorial:
    ;; Armado de stackframe
    push ebp
    mov ebp, esp

    ;; Guardo copia del @n en el eax (registro de salida por convencion de C)
    mov eax, [ebp + 8]
    ;; Guardo copia de la copia, para usar de multiplicador
    mov ebx, eax
    dec ebx
    cmp eax, 1 ;; Comparo el parametro ingresado con 1
    jle zero_case ;; Si el parametro que me pasan es menor o igual a 1, voy al caso de zero

.multiplication_loop:
    mul ebx ;; Multiplica eax con ebx y deja la respuesta en eax
    dec ebx
    jnz .multiplication_loop

.print_number:
    

end:


zero_case:
    mov eax, 1
    jmp end

section .data

section .bss
    buffer resb 32

