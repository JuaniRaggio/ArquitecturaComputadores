; libasm.asm
        global pid
pid:
        push ebp
        mov ebp, esp
        mov eax, 0x14   ;syscall getpid
        int 0x80
        ;; el resultado ya está en eax
        mov esp, ebp
        pop ebp
        ret
