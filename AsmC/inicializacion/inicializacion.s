	.file	"inicializacion.c"
	.intel_syntax noprefix
	.text
.globl	numeros_globales_sin_inicializar
;; Primero los sin inicializar, notemos que no hay ninguna aclaracion de llenar con zero
.bss				; Notemos que todas las globales van dentro de bss
	.align 32		; Alineamiento a palabra
	.type	numeros_globales_sin_inicializar, @object
	.size	numeros_globales_sin_inicializar, 80 ; Efectivamente se reservan 20*4 bytes
numeros_globales_sin_inicializar:
;;; Notemos que a pesar de que no se inicializo el arreglo, automaticamente lo inicializa en zero
	.zero	80
	.globl	numeros_globales_inicializados
	.align 32
	.type	numeros_globales_inicializados, @object
	.size	numeros_globales_inicializados, 80
numeros_globales_inicializados:
;;; Lo primero que hace es aclarar que esta zona de memoria tiene que estar llena de zeros con .zero 80
	.zero	80
	.text
	.globl	inicializacion_arreglos
	.type	inicializacion_arreglos, @function
inicializacion_arreglos:
	push	ebp
	mov	ebp, esp
	push	edi
	sub	esp, 180	; Reserva espacio para variables locales
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR -12[ebp], eax
	xor	eax, eax
	lea	edx, -172[ebp]
	mov	eax, 0
	mov	ecx, 20
	mov	edi, edx
	rep stosd
	mov	DWORD PTR -52[ebp], 69
	nop
	mov	eax, DWORD PTR -12[ebp]
	sub	eax, DWORD PTR gs:20
	je	.L2
	call	__stack_chk_fail_local
.L2:
	mov	edi, DWORD PTR -4[ebp]
	leave
	ret
	.size	inicializacion_arreglos, .-inicializacion_arreglos
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
	ret
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
