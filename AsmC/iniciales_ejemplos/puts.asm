        section .rodata
        STDOUT equ 1

        section .text

        global puts
        global strlen
        extern sys_write

puts:
        push    ebp
        mov     ebp, esp
        ;; No es necesario hacer backup de eax porque es donde vamos a ret
        push    dword ptr [ebp + 8] ; pusheo el string a leer
        call    strlen

        ;; Pusheo parametros en orden inverso al que se reciben en sys_write
        push    eax
        push    dword [ebp + 8]
        push    STDOUT
        call    sys_write
        add     esp, 3*4        ; Limpio stack, se pushearon 3 veces 32 bits
        leave                   ; Desarmado de stack frame
        ret

strlen:
;;; No usa stack por lo que no es necesario hacer armado y desarmado
        xor     eax, eax        ; Inicializo iterador
.loop:
        cmp     byte [ebp + 4 + eax], 0  ; Comparo con final de str
        je      .end
        inc     eax                      ; Incremento iterador
        jmp     .loop

.end:
        ret
