; Dado un número n, imprimir la suma de los primeros 
; n números naturales (No utilizar una fórmula).
; @n se recibe por stack y supongo parametro de 4 bytes

section .text ;; Codigo

global sumn
extern num2str

sumn:
    push ebp ;; Backup ebp_SO
    mov ebp, esp ;; New Base pointer (Nueva base de stack)
    ;; En ebp + 8 tenemos el primer parametro, en ebp + 4 se tiene la direccion de retorno
    xor eax, eax
    mov ebx, [ebp + 8] ;; Copia del @n

    ;; ERROR:
    ;; El problema de leer de "entrada estandar" es que
    ;; los parametros son strings, no son numeros, por lo tanto
    ;; estaria mal leer el string y pasarselo directo a num2str
    ;; ya que num2str recibe un numero

sum:
    add eax, ebx ;; Agrego el digito
    jo error_exit ;; Si hubo overflow, salto al error
    dec ebx ;; Decremento el @n
    jnz sum ;; Si no se hizo 0 el @n, sigo en el loop
    push buffer ;; Pusheo la zona de memoria
    push eax ;; Pusheo el numero a escribir
    call num2str
    mov eax, 4
    mov ecx, buffer ;; Muevo a ecx el puntero al inicio del string
    mov edx, ebx ;; num2str me deja en ebx el length del string
    xor ebx, ebx ;; 0 exit code (No problemo)


end: ;; Espera que ya este seteado el exitcode
    ;; Desarmado de stackframe
    mov esp, ebp
    pop ebp
    ;; Exit Syscall
    mov eax, 1
    int 80h


error_exit:
    ;; Write syscall
    mov eax, 4
    mov ecx, of_error
    mov edx, error_length
    ;; Exit syscall
    mov ebx, 1 ;; 1 exit code (Problemo)
    jmp end


section .data
    of_error db "Overflow!", 10
    error_length equ $ - of_error
    buffer resb 32

