	.file	"structs_parametros.c"
	.intel_syntax noprefix
	.text
	.globl	recibidor_x_copia
	.type	recibidor_x_copia, @function
;;; ============================================================================
;;; Notemos que no hay diferencia significativa desde andentro de la funcion en
;;; caso de que no quieran acceder a los atributos del struct
recibidor_x_copia:
	;; Armado stack frame
	push	ebp
	mov	ebp, esp
	;; Cacheo
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	nop			; No hace nada pero es para alinear
	pop	ebp
	ret
	.size	recibidor_x_copia, .-recibidor_x_copia
	.globl	recibidor_x_referencia
	.type	recibidor_x_referencia, @function
recibidor_x_referencia:
	;; Armado stack frame
	push	ebp
	mov	ebp, esp
	;; Cacheo
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	nop			; Idem arriba
	;; Desarmado
	pop	ebp
	ret
	.size	recibidor_x_referencia, .-recibidor_x_referencia
	.globl	main
	.type	main, @function
;;; ============================================================================

main:
	lea	ecx, 4[esp]	  ; Guarda el primer parametro (argc) en ecx
	and	esp, -16	  ; Alineacion a palabra
	push	DWORD PTR -4[ecx] ; Pushea el retorno al SO (pues esta arriba de argc (el primer parametro))
	;; Armado de stack frame
	push	ebp
	mov	ebp, esp
	push	ecx		; Backup ecx
	sub	esp, 20		; Reserva para variables locales
	;; Cacheo
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR -12[ebp], eax
	xor	eax, eax	; Inicializa eax en 0

;;; NOTEMOS QUE SE PUSHEAN TODOS LOS ATRIBUTOS DEL STRUCT COMO SI FUERAN ARGUMENTOS DISTINTOS
;;; entonces es como si se pasaran 3 parametros para la funcion que recibe por copia
	push	DWORD PTR -16[ebp]
	push	DWORD PTR -20[ebp]
	push	DWORD PTR -24[ebp]
	call	recibidor_x_copia
	add	esp, 12		; Limipeza de stack
	;; Lee la variable local (puntero) y la mete en un registro (eax)
	lea	eax, -24[ebp]
;;; Pushea el puntero al stack como unico parametro
;;; ES MAS EFICIENTE PORQUE SOLO PASAS UN PARAMETRO
	push	eax
	call	recibidor_x_referencia
	add	esp, 4
	mov	eax, 0
	mov	edx, DWORD PTR -12[ebp]
	sub	edx, DWORD PTR gs:20
	je	.L5
	call	__stack_chk_fail_local
.L5:
	mov	ecx, DWORD PTR -4[ebp]
	leave
	lea	esp, -4[ecx]
	ret
	.size	main, .-main
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
