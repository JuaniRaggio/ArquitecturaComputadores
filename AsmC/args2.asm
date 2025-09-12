global main
extern printf

section .rodata
        fmt db "Cantidad de argumentos %d\n", 0

section .text
main:
        push ebp
        mov ebp, esp

        push dword [ebp + 8]
        push fmt
        call printf

        mov esp, ebp
        pop ebp
        mov eax, 0
        ret
