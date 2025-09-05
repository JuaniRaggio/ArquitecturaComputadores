section .text

extern num2str

global factorial

;; Dado un número n, imprimir su factorial.
;; Tenga cuidado con los argumentos de la función.
;; - IN: n - número para calcular factorial
;; - OUT: void - imprime resultado por stdout
;; - STACK: n(ebp+8) - parámetro de entrada
;; - REG: eax=resultado, ebx=multiplicador


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
    dec ebx ;; Decremento el "iterador" que en realidad es el multiplicador
    jnz .multiplication_loop


print_number:
    push buffer
    push eax
    call num2str ;; num2str ya me deja en edx el size
    ;; Write syscall
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 80h

end:
    ;; Desarmado de stack frame
    mov esp, ebp
    pop ebp
    ret


zero_case:
    mov eax, 1
    jmp print_number


section .bss
    buffer resb 32

