section .text
GLOBAL _start
_start:
mov ecx, cadena ; Puntero a la cadena
mov edx, longitud ; Largo de la cadena
mov ebx, 1 ; FileDescriptor (STDOUT)
mov eax, 4 ; ID del Syscall WRITE
int 80h ; Ejecución de la llamada
mov eax, 1 ; ID del Syscall EXIT
mov ebx, 0 ; Valor de Retorno
int 80h ; Ejecución de la llamada
section .data
cadena db "Hola Mundo!!", 10 ;"Hola Mundo!!\n"
longitud equ $-cadena
section .bss
placeholder resb 10
