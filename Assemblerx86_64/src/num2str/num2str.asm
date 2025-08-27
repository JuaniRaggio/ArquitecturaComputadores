;; @num2str
;; función que recibe un @número y una @zona_de_memoria, y
;; transforma el número en un string,
;; terminado con cero, en la zona de memoria pasada
;; como parámetro

section .text ;; Codigo

global num2str

num2str:
    ;; Armado de stack frame
    push ebp ;; Backup del base pointer
    mov ebp, esp ;; Muevo al base pointer a la base del stack de esta funcion
    ;; Acceso a parametros -> por ebp
    ;; Los parametros vamos a suponer que son todos de 4 bytes
    ;; En ebp + 4 (Bytes) -> Retorno (Porque pusheamos el ebp del SO)

    mov edx, 0 ;; edx va a ser el offset
    cmp dword [ebp + 12], 0
    ja positive

;; Recordar que para el resto, se usa:
;; A/B => A = B * C + Resto => Resto = A - B * C

negative:
    push ebp + 12

    push [ebp + 8]
    push 31
    call put_char

positive:

    ;; Desarmado de stack frame
    mov esp, ebp
    pop ebp
    ret

get_next_digit:
    ;; Recibe por stack un numero
    ;; Deja en AL el siguiente digito en forma de char


put_char: 
    ;; Recibe en AL el char a colocar
    ;; en el stack: zona_de_memoria_a_escribir, offset (Donde colocar el char)
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8] ;; Muevo a ebx, la direccion de memoria donde comienza el string

    mov ecx, [ebp + 12] ;; Muevo a ecx, el offset (donde deberia escribirse el char)

    mov [ebx + ecx], al

    ;; ESTO ESTA MAL
    ; mov [ebp + 8] + ebp + 12, al

    mov esp, ebp
    pop ebp
    ret

section .data
    sign db '-'

section .bss ;; Better Save Space
    buffer resb 32

