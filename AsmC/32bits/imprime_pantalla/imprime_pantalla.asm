;;; Falta hacer la parte de error
        global imprime_pantalla
        section .text

imprime_pantalla:
;;; BRIEF:
;;;        - Debe imprimir dos cadenas de caracteres en una pantalla de 480
;;;          monocromaticos (80 columnas y 6 filas)
;;;        - En la primera fila: encabezado
;;;        - En la ultima fila: pie
;;; IN:
;;;        - char * encabezado: Cadena a escribir en la primer fila
;;;        - int tam_enc: Tamaño de la cadena encabezado
;;;        - char * pie: Cadena a escribir en la ultima fila
;;;        - int tam_pie: Tamaño de la cadena pie
;;; OUT:
;;;        - 1     Si recibe un valor fuera del rango del buffer
;;;        - 0     Si la rutina se ejecuta exitosamente

        ;; Armado de stack frame
        push    ebp
        mov     ebp, esp
        ;; Backup de registros que voy a usar
        push    ebx
        push    ecx

        ;; Checkeo de lengths correctas
        push    dword [ebp + 8]  ; Pusheo el encabezado
        call    strlen
        mov     ebx, eax
        cmp     ebx, [ebp + 12]  ; Comparo con el supuesto size
        jne     error_exit       ; Si no es real, tiro error
        cmp     ebx, cols        ; Comparo con el limite
        jg      error_exit       ; Si ebx greater cols, salto a error
        push    dword [ebp + 16] ; Pusheo el pie
        call    strlen
        mov     ecx, eax
        cmp     ecx, [ebp + 20]  ; Comparo con el supuesto size
        jne     error_exit       ; Si no es real, tiro error
        cmp     ecx, cols        ; Comparo con el limite
        jg      error_exit       ; Si ebx greater cols, salto a error
        mov     eax, 0           ; Inicializacion de valor de retorno
                                 ; pues ya sabemos que no vamos a tener error


        ;; Escritura - Pie
        ;; Notemos que el pie esta arriba en el stk
        push    dword cols * (rows - 1) ; Ultimo renglon
        call    .cp_str

        mov     eax, 4
        mov     ebx, 1
        mov     ecx, buffer
        mov     edx, rows * cols
        int     80h

        add     esp, 12           ; Limpio el stack para popear backups
                                  ; y dejarlo igual que cuando se llamo
                                  ; a esta funcion

        ;; Levanto backups
        pop     ecx
        pop     ebx

        ;; Desarmado de stack frame
        leave
        ret


.cp_str:
;;; IN:
;;;     - offset: En que posicion empezamos a escribir respecto de buffer
;;;     - str: Que escribimos?
        push    ebp
        mov     ebp, esp

        ;; Backup registers
        push    esi
        push    edi

        ;; Inicializacion de indices
        mov     edi, [ebp + 8]  ; Inicializamos el indice en donde escribir
                                ; respecto del buffer
        mov     esi, [ebp + 12] ; SourceIndex, de donde tomar la informacion

.loop:
        mov     byte [buffer + edi], [esi]
        inc     edi
        inc     esi
        cmp     byte [esi], 0   ; source index esta en el 0 final?
        jne     .loop           ; Si no, segui en el loop

        ;; Recupero backup
        pop     edi
        pop     esi

        ;; Desarmado de stack frame
        leave
        ret

strlen:
        push    ebp
        mov     ebp, esp
        push    ecx             ; Backup esi
        mov     ecx, -1         ; Inicializo contador

.loop:
        inc     ecx                     ; Incremento iterador
        jo      error_exit              ; Si hubo overflow me las tomo
        cmp     byte [ebp + 8 + ecx], 0 ; Comparo con fin
        jne     .loop                   ; Si no es fin, sigo sumando
        pop     ecx                     ; Levanto el backup
        leave
        ret

        section .rodata
        cols    equ 80
        rows    equ 6
        buffer  equ 0xA0000000
