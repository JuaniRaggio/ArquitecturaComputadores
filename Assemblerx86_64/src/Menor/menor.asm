;; Escribir un programa que dado un array de números enteros,
;; de 4 bytes, encuentre el menor, y lo imprima por salida estándar.

global _start

_start:
        xor eax, eax


section .data
        array dw 1, 2, 10, 3, 1, 0, 1, 23, 40
        length equ $ - array

section .bss
        array resb 32
