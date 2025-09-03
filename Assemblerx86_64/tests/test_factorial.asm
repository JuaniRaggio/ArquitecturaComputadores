section .data
    test_msg1 db "=== Test Factorial ===", 10, 0
    test_msg1_len equ $ - test_msg1 - 1
    
    test1_msg db "Test 1 - factorial(0): ", 0
    test1_msg_len equ $ - test1_msg - 1
    
    test2_msg db "Test 2 - factorial(1): ", 0
    test2_msg_len equ $ - test2_msg - 1
    
    test3_msg db "Test 3 - factorial(5): ", 0
    test3_msg_len equ $ - test3_msg - 1
    
    test4_msg db "Test 4 - factorial(10): ", 0
    test4_msg_len equ $ - test4_msg - 1
    
    test5_msg db "Test 5 - factorial(-3): ", 0
    test5_msg_len equ $ - test5_msg - 1
    
    newline db 10, 0
    newline_len equ $ - newline - 1

section .text
extern factorial

global _start

_start:
    ; Print header
    mov eax, 4
    mov ebx, 1
    mov ecx, test_msg1
    mov edx, test_msg1_len
    int 80h
    
    ; Test 1: factorial(0)
    mov eax, 4
    mov ebx, 1
    mov ecx, test1_msg
    mov edx, test1_msg_len
    int 80h
    
    push 0
    call factorial
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 2: factorial(1)
    mov eax, 4
    mov ebx, 1
    mov ecx, test2_msg
    mov edx, test2_msg_len
    int 80h
    
    push 1
    call factorial
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 3: factorial(5)
    mov eax, 4
    mov ebx, 1
    mov ecx, test3_msg
    mov edx, test3_msg_len
    int 80h
    
    push 5
    call factorial
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 4: factorial(10)
    mov eax, 4
    mov ebx, 1
    mov ecx, test4_msg
    mov edx, test4_msg_len
    int 80h
    
    push 10
    call factorial
    add esp, 4
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 80h
    
    ; Test 5: factorial(-3)
    mov eax, 4
    mov ebx, 1
    mov ecx, test5_msg
    mov edx, test5_msg_len
    int 80h
    
    push -3
    call factorial
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