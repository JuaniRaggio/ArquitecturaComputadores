global main
extern printf

section .rodata
        fmt db "Cantidad de argumentos: %d\n", 0

section .text
main:
;;; Imprimir cantidad de argumentos y cada uno de los argumentos
        pushad                  ; Guardo backup de registros
        mov ebp, esp

        mov ecx, 8              ; Inicializo "sumador" en 0
        mov edi, 0

        push dword [ebp + ecx]
        push fmt
        call printf
        add esp, 2*4

print_args:
        add ecx, 4
        push dword [ebp + ecx]
        call printf
        add esp, 4
        inc edi
        cmp edi, [ebp + 8]      ; Comparo el contador con argc
        jne print_args

        mov esp, ebp            ; Desarmado de stack frame
        popad                   ; Backup registros
        mov eax, 0              ; Retorno
        ret
