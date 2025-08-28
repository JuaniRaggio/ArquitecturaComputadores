;; Supongo que @{numero} sea positivo, despues lo extiendo
;; @num2str
;; función que recibe un @{número} y una @{zona_de_memoria}, y
;; transforma el número en un string,
;; terminado con cero, en la zona de memoria pasada
;; como parámetro

section .text ;; Codigo

global num2str

num2str:
    ;; Armado de stack frame
    push ebp ;; Backup del base pointer
    mov ebp, esp ;; Muevo al base pointer a la base del stack de esta funcion
    mov eax, [ebp + 8] ;; Me guardo una copia del numero
    mov edi, [ebp + 12]
    mov ebx, 10 ;; Divisor
    mov ecx, 0 ;; Contador


zero_special:
    cmp eax, 0
    jne positive
    mov [edi], '0'
    mov [edi + 1], 0
    jmp end


positive:
    xor edx, edx ;; Para evitar restos de anteriores operaciones
    div ebx ;; Div toma a eax como numerador y guarda el resto en edx
    add dl, '0' ;; Le sumo al numero para que represente el ascii
    push dx ;; Empujo el caracter al stack
    inc ecx ;; Aumento el contador
    cmp eax, 0 ;; Comparo el numero con 0
    jg positive ;; Si el numero sigue siendo mayor a 0 despues de la division, sigo en el loop
    

    xor ebx, ebx
pop_data:
    ;; Aca faltaria popear todos los chars 
    ;; que se pushearon de forma inversa
    pop ax ;; Levanto el numero que tengo que escribir (Me queda el char en AL)
    mov [edi + ebx], al ;; Copio el byte bajo que es el unico que contiene el numero
    inc ebx ;; Aumento el iterador
    cmp ecx, ebx ;; Comparo el iterador con la cantidad de digitos que tiene el numero
    jg pop_data ;; Si ecx (cantidad de digitos) es mayor ebx (iterador), sigo en el loop
    mov byte [edi + ebx], 0 ;; Agregar el cero final
    inc ebx


end:
    ;; Desarmado de stack frame
    mov esp, ebp
    pop ebp
    ret

; Para microoptimizaciones, es preferible usar magic numbers
; section .data
;     divisor dd 10
;     num_ascii_gap db '0'
