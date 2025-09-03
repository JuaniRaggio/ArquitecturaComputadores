section .data
    test_msg1 db "=== Test Num2str ===", 10, 0
    test_msg1_len equ $ - test_msg1 - 1
    
    test1_msg db "Test 1 - num2str(0): ", 0
    test1_msg_len equ $ - test1_msg - 1
    
    test2_msg db "Test 2 - num2str(42): ", 0
    test2_msg_len equ $ - test2_msg - 1
    
    test3_msg db "Test 3 - num2str(123): ", 0
    test3_msg_len equ $ - test3_msg - 1
    
    test4_msg db "Test 4 - num2str(9999): ", 0
    test4_msg_len equ $ - test4_msg - 1
    
    newline db 10, 0
    newline_len equ $ - newline - 1

section .bss
    buffer resb 32

section .text
extern num2str

global _start

_start:
    ; Print header
    mov eax, 4
    mov ebx, 1
    mov ecx, test_msg1
    mov edx, test_msg1_len
    int 80h
    
    ; Test 1: num2str(0)
    mov eax, 4
    mov ebx, 1
    mov ecx, test1_msg
    mov edx, test1_msg_len
    int 80h
    
    push buffer
    push 0
    call num2str
    add esp, 8
    
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 2: num2str(42)
    mov eax, 4
    mov ebx, 1
    mov ecx, test2_msg
    mov edx, test2_msg_len
    int 80h
    
    push buffer
    push 42
    call num2str
    add esp, 8
    
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 3: num2str(123)
    mov eax, 4
    mov ebx, 1
    mov ecx, test3_msg
    mov edx, test3_msg_len
    int 80h
    
    push buffer
    push 123
    call num2str
    add esp, 8
    
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 4: num2str(9999)
    mov eax, 4
    mov ebx, 1
    mov ecx, test4_msg
    mov edx, test4_msg_len
    int 80h
    
    push buffer
    push 9999
    call num2str
    add esp, 8
    
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Exit
    mov eax, 1
    mov ebx, 0
    int 80h