	.file	"structs_parametros.c"
	.intel_syntax noprefix
	.text
	.globl	recibidor_x_copia
	.type	recibidor_x_copia, @function
recibidor_x_copia:
	push	ebp
	mov	ebp, esp
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR 8[ebp]
	mov	edx, DWORD PTR 12[ebp]
	mov	DWORD PTR [eax], edx
	mov	edx, DWORD PTR 16[ebp]
	mov	DWORD PTR 4[eax], edx
	mov	edx, DWORD PTR 20[ebp]
	mov	DWORD PTR 8[eax], edx
	mov	eax, DWORD PTR 8[ebp]
	pop	ebp
	ret	4
	.size	recibidor_x_copia, .-recibidor_x_copia
	.globl	recibidor_x_referencia
	.type	recibidor_x_referencia, @function
recibidor_x_referencia:
	push	ebp
	mov	ebp, esp
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR 8[ebp]
	pop	ebp
	ret
	.size	recibidor_x_referencia, .-recibidor_x_referencia
	.globl	main
	.type	main, @function
main:
	lea	ecx, 4[esp]
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	ecx
	sub	esp, 36
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR -12[ebp], eax
	xor	eax, eax
	lea	eax, -40[ebp]
	push	DWORD PTR -16[ebp]
	push	DWORD PTR -20[ebp]
	push	DWORD PTR -24[ebp]
	push	eax
	call	recibidor_x_copia
	add	esp, 12
	lea	eax, -24[ebp]
	push	eax
	call	recibidor_x_referencia
	add	esp, 4
	mov	eax, 0
	mov	edx, DWORD PTR -12[ebp]
	sub	edx, DWORD PTR gs:20
	je	.L7
	call	__stack_chk_fail_local
.L7:
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
