;;; Escribir un programa que muestre en pantalla la cantidad de parametros que recibio por stack

section .text
global _start
extern num2str

write_buffer:
        ;; Espera tener edx seteado
        push ebp                ; Armado de stack frame
        mov ebp, esp

        push eax                ; Backup de registros
        push ebx
        push ecx

        mov eax, 4              ; Syscall code
        mov ebx, 1              ; output code
        mov ecx, [ebp + 8]      ; What to read
        int 80h                 ; Interruption

        pop ecx                 ; Levanto backup de registros en orden inverso
        pop ebx
        pop eax

        mov esp, ebp            ; Desarmado de stack frame
        pop ebp
        ret

_start:
        push ebp                ; Armado de stack frame
        mov ebp, esp            ; Armado de stack frame
        mov edx, cantidad_length ; Muevo longitud del string a printear a edx
        push cantidad_msg       ; Pusheo lo que tengo que escribir: "Cantidad de argumentos: "
        call write_buffer        ; Llamado a funcion write
        mov ecx, 8
        mov ebx, [ebp + ecx]    ; Guardo el primer parametro (cantidad de argumentos)
        push buffer             ; Push buffer
        push ebx                ; Push primer parametro (cantidad de argumentos)
        call num2str
        push buffer             ; Pusheo lo que tengo que escribir (ya esta volcado en el buffer por num2str)
        call write_buffer

        xor eax, eax
put_arguments:
        add ecx, 4              ; Aumento el contador para ir al siguiente argumento (primer argv)

        ;; Print new_line
        mov edx, new_line_length
        push new_line           ; Pusheo lo que tengo que escribir (una constante)
        call write_buffer

        ;; Print pre-number message
        mov edx, pre_num_length
        push pre_num
        call write_buffer

        ;; Print number of argv (position from 0 to argc - 1)
        push buffer
        push eax
        call num2str
        push buffer
        call write_buffer

        ;; Print post-number message
        mov edx, post_num_length
        push post_num
        call write_buffer

        ;; Print Argument (already a string)
        mov ebx, [ebp + ecx]    ; Cargo en ebx el argumento a printear
        push ebx                ; Pusheo el argumento
        call write_buffer

        inc eax                 ; Incremento el iterador
        cmp eax, [ebp + 8]      ; Comparo el iterador con argc (cantidad de argumentos)
        jne put_arguments

        ;; Print new_line
        mov edx, new_line_length
        push new_line           ; Pusheo lo que tengo que escribir (una constante)
        call write_buffer

end:
;;; Exit syscall
        mov eax, 1
        mov ebx, 0
        int 80h

section .data
        cantidad_msg db "Cantidad de argumentos: "
        cantidad_length equ $ - cantidad_msg
        new_line db 10
        new_line_length equ $ - new_line
        pre_num db "argv["
        pre_num_length equ $ - pre_num
        post_num db "]: "
        post_num_length equ $ - post_num
        multiplier db 10

section .bss
        buffer resb 32
