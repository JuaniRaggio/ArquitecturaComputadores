	.file	"factorial.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
	;; Armado de stack frame
	push	ebp
	mov	ebp, esp

	;; Reserva 24 bytes para variables locales
	sub	esp, 24
	call	__x86.get_pc_thunk.ax ; direccion de memoria de ax

	;; Agrega a GOT el retorno de la funcion
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	cmp	DWORD PTR 8[ebp], 0 ; Compara con 0 el parametro
	jne	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	mov	eax, DWORD PTR 8[ebp]
	sub	eax, 1
	sub	esp, 12		; Aca esta reservando espacio para fac_n_1
	push	eax
	call	factorial
	add	esp, 16
	mov	DWORD PTR -12[ebp], eax
	mov	eax, DWORD PTR 8[ebp]
	imul	eax, DWORD PTR -12[ebp]
.L3:
	leave
	ret
	.size	factorial, .-factorial
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
