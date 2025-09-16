;;; check_long.asm
;;; 32 bits => Se reciben parametros por stack en el respectivo orden
;;;             de manera tal que queden ordenados en el stack de arriba
;;;             hacia abajo
;;;         => Se retornan en eax
        section .text

        global check_long

check_long:
;;; BRIEF:
;;;     - Recorre el vector hasta encontrar un cero
;;;     - Luego compara con el valor siguiente al cero (deberia ser 2do param)
;;;     - Verifica si efectivamente es la longitud
;;; IN:
;;;     - STACK: Direccion de inicio (4 bytes)
;;;     - STACK: Cantidad de elementos (4 bytes)
;;; OUT:
;;;     - EAX: Diferencia entre el valor calculado y el valor informado
        ;; Armado de stack frame
        push ebp
        mov ebp, esp

        mov eax, -1             ; Inicializo contador en -1 (ver 28 el xq)
        mov esi, [ebp + 8]      ; Muevo al source index la direccion de memoria del str

.loop:
        inc eax                 ; Incremento contador, habia empezado en -1
                                ; asique puedo empezar incrementando
        jo error                ; Si hubo overflow, salto al error
        cmp byte [esi + eax], 0 ; Comparo char con 0 (final)
        jne .loop

end:
        sub eax, [ebp + 12]     ; Tengo que retornar la diferencia entre lo
                                ; que tienen vs lo que me pasaron
        ;; Desarmado de stack frame
        mov esp, ebp
        pop ebp
        ret

error:
        ;; write syscall
        mov eax, 4
        mov ebx, 2              ; En stderr
        mov ecx, error_msg
        mov edx, error_length
        int 80h
        ;; exit_syscall
        mov eax, 1
        mov ebx, 1              ; Codigo de error con el que exitea
        int 80h

        section .data
        error_msg db "Demasiados caracteres, hubo overflow!", 10
        error_length equ $ - error_msg
;; msg:    db "Hola Mundo", 0
;; len:    db 10
