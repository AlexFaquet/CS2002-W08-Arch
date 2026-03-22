	.text
	.file	"gcd.c"
	.globl	gcd
	.p2align	4, 0x90
	.type	gcd,@function
gcd:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, %eax
	testl	%esi, %esi
	je	.LBB0_1
	movl	%esi, %edx
	.p2align	4, 0x90
.LBB0_3:
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.LBB0_3
	jmp	.LBB0_4
.LBB0_1:
	movl	%eax, %ecx
.LBB0_4:
	movl	%ecx, %eax
	negl	%eax
	cmovsl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
