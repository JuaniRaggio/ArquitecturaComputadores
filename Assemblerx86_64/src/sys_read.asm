section .data
        buffer db 1
        mayusc_offset equ "a" - "A"

section .text

read_char:
;;; Reading one char
        mov eax, 3              ; sys_read code
        mov ebx, 0              ; stdin
        mov ecx, buffer         ; Buffer para copiar lo leido
        mov edx, 1
        int 80h

        ;; Si llego a EOF (0 bytes leidos), que salte a end
        cmp eax, 0              ; eax <- Cantidad de bytes que se leyeron
        je end

        cmp byte [buffer], "a"  ; Comparo con a minuscula
        jb write                ; Si lei menor a "a", ya puedo escribir
        cmp byte [buffer], "z"
        ja write                ; Si lei mayor a "z", ya puedo escribir

        ;; Si no lei menor a "a" y no lei mayor a "z", lei entre "a" y "z"
        ;; entonces tengo que hacer to_upper

to_upper:
        sub byte [buffer], mayusc_offset

write:
;;; Writing one char
        mov eax, 4              ; sys_write code
        mov ebx, 1              ; stdout
        mov ecx, buffer         ; Buffer with data to write
        mov edx, 1              ; Only one byte to write
        int 80h
        jmp read_char

end:
;;; Exit syscall
        mov eax, 1
        mov ebx, 0
        int 80h
