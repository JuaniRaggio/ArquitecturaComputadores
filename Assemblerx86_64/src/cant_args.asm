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
        push cantidad_msg       ; Mensaje de "Cantidad de argumentos: "
        mov edx, cantidad_length ; Muevo longitud del string a printear a edx
        call write_buffer        ; Llamado a funcion write
        mov ecx, 8               ; Inicializo contador para empezar en argc
        mov ebx, [ebp + ecx]    ; Guardo el primer parametro (cantidad de argumentos)
        push buffer             ; Push buffer
        push ebx                ; Push primer parametro (cantidad de argumentos)
        call num2str
        push buffer             ; Pusheo el buffer para el write_buffer
        call write_buffer

put_arguments:
        add ecx, 4              ; Aumento el contador para ir al siguiente argumento (primer argv)

        ;; Print new_line
        mov edx, new_line_length
        push new_line
        call write_buffer

        ;; Print pre-number message
        mov edx, pre_num_length
        push pre_num
        call write_buffer

        ;; Print number of argv (position from 0 to argc - 1)
        mov

        ;; Print post-number message
        mov edx, post_num_length
        push post_num
        call write_buffer

        mov ebx, [ebp + ecx]    ; Cargo en ebx el argumento a printear
        push buffer             ; Pusheo el buffer (segundo argumento para num2str)
        push ebx                ; Pusheo el numero (primer argumento para num2str)
        call num2str
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

section .bss
        buffer resb 32
