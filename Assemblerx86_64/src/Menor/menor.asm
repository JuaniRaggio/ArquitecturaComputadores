;; Escribir un programa que dado un array de números enteros,
;; de 4 bytes, encuentre el menor, y lo imprima por salida estándar.

;;; Esta hecho para numeros positivos, para negativos lo que habria que
;;; cambiar es que eax se inicialice con FFFF

extern num2str
global _start

_start:
        xor eax, eax            ; Inicializo eax en 0 (menor numero entero positivo)
        mov esi, array          ; Copia del puntero a la primer direccion de memoria

find_minimum:
        cmp esi, end_of_array   ; Comparo con el final del array
        jge end                 ; Si el puntero esta despues o a la altura del final, no hay mas que hacer
        cmp eax, [esi]          ; Comparo el ultimo menor contra
        jg minimum_found        ; Si el ultimo menor es mayor, lo piso con el nuevo menor
inc_iterator:
        add esi, 4              ; Inc puntero
        jmp find_minimum

minimum_found:
        mov eax, [esi]
        jmp inc_iterator

end:
        push buffer             ; Buffer primero => aparece mas abajo en la pila
        push eax                ; Numero segundo => aparece arriba del buffer
        call num2str            ; Recibe mas arriba el numero primero y la zona de memoria despues
        ;; num2str ya me deja en edx el size del string a printear
        mov eax, 4
        mov ebx, 1
        mov ecx, buffer


section .data
        array dd 1, 2, 10, 3, 1, 0, 1, 23, 40
        end_of_array equ $

section .bss
        array resb 32
        buffer resb 32
