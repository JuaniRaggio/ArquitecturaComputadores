; ejemplo.s
main:
        ;; Armado
        push ebp
        mov ebp, esp
        ;; Alineamiento
        and esp, -16
        ;; Reserva para variables locales
        sub esp, 32
        ;; 4 bytes que ocupan del 19 al 22
        mov DWORD PTR [esp+19], 1819043176
        ;; 4 bytes que ocupan del 23 al 26
        mov DWORD PTR [esp+23], 1870078063
        ;; 4 bytes que ocupan del 27 al 30
        mov DWORD PTR [esp+27], 174353522
        ;; 1 byte que ocupa el 31
        mov BYTE PTR [esp+31], 0
        ;; guarda en eax lo que esta en la direccion de memoria 1819043176d
        lea eax, [esp+19]
        ;; pushea lo que esta en eax
        mov DWORD PTR [esp], eax
        call magia
        ;; Pisa eax con lo que esta en la direccion de memoria de [esp + 19]
        lea eax, [esp+19]
        ;; Pushea lo que esta en eax
        mov DWORD PTR [esp], eax
        call printf             ; Printea lo que estaba en eax
        mov eax, 0
        leave

magia:
        ;; Armado
        push ebp
        mov ebp, esp
        ;; Reserva
        sub esp, 16
        jmp .L4
        .L6:
        mov eax, DWORD PTR [ebp+8]
        movzx eax, BYTE PTR [eax]
        cmp al, 96
        jle .L5
        mov eax, DWORD PTR [ebp+8]
        movzx eax, BYTE PTR [eax]
        cmp al, 122
        jg .L5
        mov eax, DWORD PTR [ebp+8]
        movzx eax, BYTE PTR [eax]
        mov BYTE PTR [ebp-1], al
        movzx eax, BYTE PTR [ebp-1]
        sub eax, 32
        mov BYTE PTR [ebp-1], al
        mov eax, DWORD PTR [ebp+8]
        movzx edx, BYTE PTR [ebp-1]
        mov BYTE PTR [eax], dl
.L5:
        add DWORD PTR [ebp+8], 1
.L4:
        ;; Mete en eax el primer parametro
        mov eax, DWORD PTR [ebp+8]
        ;; Mueve un byte de lo que esta en eax y todo lo demas lo pone en cero
        movzx eax, BYTE PTR [eax]
        ;; Hace un and logico con la parte que movio
        ;; si al es cero, no salta
        test al, al
        jne .L6
        leave
        ret
