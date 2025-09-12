	.file	"arguments.c"	; Nombre del archivo fuente
	.intel_syntax noprefix	; Syntaxis intel
	.text
	.section	.rodata
.LC0:				; Etiqueta para el literal
	.string	"Cantidad de argumentos %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	;; Ojo aca porque hacer ecx = esp + 4, hace que ecx guarde una
	;; direccion de memoria, seria como tener ecx = &argc
	lea	ecx, 4[esp]	; Esto es como hacer ecx = esp + 4 (1er arg)

	and	esp, -16	  ; Alinea esp a un multiplo de 16 bytes

	;; Ojo porque alinear a palabra puede hacer que se pierda o se rompa
	;; la posicion original del return address, entonces la siguiente
	;; linea lo que esta haciendo es salvar el return address que como
	;; en ecx tenemos la direccion del primer argumento, en ecx - 4
	;; vamos a tener el retorno al systema operativo
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	ebx		; Backup de registros
	push	ecx

	;; Obtener la direccion de la Global Offset Table, en EAX
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_

	;; Argumentos para llamar a printf
	mov	edx, ecx	; edx ahora tambien apunta a &argc
	sub	esp, 8		; reserva 8 bytes de espacio local
	push	DWORD PTR [edx]	; se pushea argc

	;; Calcula la direccion relativa de la cadena .LC0 usando eax
	;; edx va a tener la direccion de la cadena
	;; "Cantidad de argumentos %d\n"
	lea	edx, .LC0@GOTOFF[eax]


	push	edx		; push puntero a "Cantidad..."
	mov	ebx, eax	; guarda la base del GOT

	;; Llama a printf via PLT (procedural linkage table) -> printf
	;; leera el formato y el entero desde la pila
	call	printf@PLT

	;; Limpia la pila, 16 porque se habian reservado 8 bytes con
	;; sub esp, 8 y se empujaron 2 argumentos
	add	esp, 16
	mov	eax, 0		; return value
	lea	esp, -8[ebp]	; ajusta esp para preparar los pop

	;; Restaura backups
	pop	ecx
	pop	ebx
	pop	ebp

	;; Calcula esp = ecx - 4 = esp_original => Restaura esp al valor que
	;; tenia al entrar a la funcion
	lea	esp, -4[ecx]
	ret
	.size	main, .-main	; marca el tamaño de la funcion main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
