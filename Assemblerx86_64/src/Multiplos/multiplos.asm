;;; Dado un número n y un valor k,
;;; imprimir todos los valores múltiplos de n desde 1 hasta k.

section .text
_start:



multiplos:
;; - IN: n, k - parámetros de entrada
;; - OUT: void - valor de retorno
;; - STACK: n(ebp+8), k(ebp+12) - ubicación en stack
;; - REG: eax=resultado, ebx=contador - uso de registros

        ;; Armado de stack frame
        push ebp
        mov ebp, esp

        mov eax, [ebp + 8]      ; Guardo copia de n en EAX
        mov ebx, [ebp + 12]     ; Inicializacion del contador

.print_results:
        push eax                ; Push number first
        add eax, eax

.stack_results:
        mult ebx
        push eax
        div ebx
        inc ebx
        jnz .stack_results

        ;; Desarmado de stack frame
        mov esp, ebp
        pop ebp

section .data

section .bss
