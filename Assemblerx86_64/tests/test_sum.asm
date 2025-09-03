section .data
    test_msg1 db "=== Test Sum ===", 10, 0
    test_msg1_len equ $ - test_msg1 - 1
    
    test1_msg db "Test 1 - sum(0): ", 0
    test1_msg_len equ $ - test1_msg - 1
    
    test2_msg db "Test 2 - sum(5): ", 0
    test2_msg_len equ $ - test2_msg - 1
    
    test3_msg db "Test 3 - sum(10): ", 0
    test3_msg_len equ $ - test3_msg - 1
    
    test4_msg db "Test 4 - sum(100): ", 0
    test4_msg_len equ $ - test4_msg - 1
    
    newline db 10, 0
    newline_len equ $ - newline - 1

section .text
extern sumn

global _start

_start:
    ; Print header
    mov eax, 4
    mov ebx, 1
    mov ecx, test_msg1
    mov edx, test_msg1_len
    int 80h
    
    ; Test 1: sum(0)
    mov eax, 4
    mov ebx, 1
    mov ecx, test1_msg
    mov edx, test1_msg_len
    int 80h
    
    push 0
    call sumn
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 2: sum(5)
    mov eax, 4
    mov ebx, 1
    mov ecx, test2_msg
    mov edx, test2_msg_len
    int 80h
    
    push 5
    call sumn
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 3: sum(10)
    mov eax, 4
    mov ebx, 1
    mov ecx, test3_msg
    mov edx, test3_msg_len
    int 80h
    
    push 10
    call sumn
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 4: sum(100)
    mov eax, 4
    mov ebx, 1
    mov ecx, test4_msg
    mov edx, test4_msg_len
    int 80h
    
    push 100
    call sumn
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Exit
    mov eax, 1
    mov ebx, 0
    int 80h