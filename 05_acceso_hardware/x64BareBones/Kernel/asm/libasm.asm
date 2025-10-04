GLOBAL cpuVendor
GLOBAL num2str
GLOBAL get_current_time

section .text
	
cpuVendor:
	push rbp
	mov rbp, rsp

	push rbx

	mov rax, 0
	cpuid


	mov [rdi], ebx
	mov [rdi + 4], edx
	mov [rdi + 8], ecx

	mov byte [rdi+13], 0

	mov rax, rdi

	pop rbx

	mov rsp, rbp
	pop rbp
	ret

;; función que recibe un número positivo y una zona_de_memoria, y
;; transforma el número en un string terminado con cero
;; - IN: numero (positivo), zona_de_memoria - parámetros de entrada
;; - OUT: void - modifica zona_de_memoria, deja length en edx
;; - STACK: numero(ebp+8), zona_de_memoria(ebp+12)
;; - REG: eax=numero, edi=puntero_memoria, ebx=divisor, ecx=contador
num2str:
    ;; Armado de stack frame
    push ebp            ;; Backup del base pointer
    mov ebp, esp        ;; Muevo al base pointer a la base del stack de esta funcion
    mov eax, [ebp + 8]  ;; Me guardo una copia del numero
    mov edi, [ebp + 12]
    mov ebx, 10         ;; Divisor
    mov ecx, 0          ;; Contador


zero_special:
    cmp eax, 0
    jne positive
    mov byte [edi], '0'
    mov byte [edi + 1], 0
    jmp end


positive:
    xor edx, edx        ;; Para evitar restos de anteriores operaciones
    div ebx             ;; Div toma a eax como numerador y guarda el resto en edx
    add dl, '0'         ;; Le sumo al numero para que represente el ascii
    push dx             ;; Empujo el caracter al stack
    inc ecx             ;; Aumento el contador
    cmp eax, 0          ;; Comparo el numero con 0
    jg positive         ;; Si el numero sigue siendo mayor a 0 despues de la division, sigo en el loop
    

    xor ebx, ebx
pop_data:
    pop ax                  ;; Levanto el numero que tengo que escribir (Me queda el char en AL)
    mov [edi + ebx], al     ;; Copio el byte bajo que es el unico que contiene el numero
    inc ebx                 ;; Aumento el iterador
    cmp ecx, ebx            ;; Comparo el iterador con la cantidad de digitos que tiene el numero
    jg pop_data             ;; Si ecx (cantidad de digitos) es mayor ebx (iterador), sigo en el loop
    mov byte [edi + ebx], 0 ;; Agregar el cero final
    inc ebx
    mov edx, ebx

end:
    ;; Desarmado de stack frame
    mov esp, ebp
    pop ebp
    ret


get_current_time:
    push  rbp
    mov   rbp, rsp

    push  rcp

    mov   rcp, time_buffer

    mov   al, 4         ; Para obtener las horas
    out   70h, al
    in    ax, 71h
    push  rcp           ; Paso el inicio del buffer para que escriba ahi la h
    push  ax            ; Paso el numero entero que representa la hora
    call  num2str

    mov   byte [rcp + 2], ':'

    mov   al, 2         ; Para obtener los minutos
    out   70h, al
    in    ax, 71h
    push  [rcp + 3]     ; Le paso la posicion en la que tiene que escribir
    push  ax
    call  num2str

    add   rsp, 8        ; Limpio stack
    pop   rcp

    mov   rax, time_buffer  ; Muevo el puntero a retornar a rax (convencion)
    leave
    ret

section .bss
    time_buffer resb 32

