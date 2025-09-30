	.file	"structs_parametros_64bits.c"
	.intel_syntax noprefix
	.text
	.globl	recibidor_x_copia
	.type	recibidor_x_copia, @function
recibidor_x_copia:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	rdx, rdi
	mov	eax, esi
	mov	QWORD PTR -32[rbp], rdx
	mov	DWORD PTR -24[rbp], eax
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -12[rbp], rax
	mov	eax, DWORD PTR -24[rbp]
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR -12[rbp]
	mov	ecx, DWORD PTR -4[rbp]
	mov	rdx, rcx
	pop	rbp
	ret
	.size	recibidor_x_copia, .-recibidor_x_copia
	.globl	recibidor_x_referencia
	.type	recibidor_x_referencia, @function
recibidor_x_referencia:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -8[rbp], rdi
	mov	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	recibidor_x_referencia, .-recibidor_x_referencia
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	rdx, QWORD PTR -20[rbp]
	mov	eax, DWORD PTR -12[rbp]
	mov	rdi, rdx
	mov	esi, eax
	call	recibidor_x_copia
	lea	rax, -20[rbp]
	mov	rdi, rax
	call	recibidor_x_referencia
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
