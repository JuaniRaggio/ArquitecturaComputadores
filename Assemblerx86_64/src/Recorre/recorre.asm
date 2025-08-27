section .text

global _start

_start:
    mov eax, esp
    mov edx, 0
    .loop:
        inc edx
        add eax, 4
        jo error_msg
        cmp eax, ebp
        jb .loop
        jmp ok_msg

    mov eax, 1
    int 80h

ok_msg:
    mov ecx, ok
    ret

error_msg:
    mov ecx, overflow
    mov ebx, 1
    ret

section .data
    overflow db "Overflow"
    length_overflow db $ - overflow
    ok db "Ok!"
    length_ok db $ - ok
    tab db 10

section .bss
    buffer resb 1024

