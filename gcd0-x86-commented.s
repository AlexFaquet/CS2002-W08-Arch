	.text
	.file	"gcd.c"
	.globl	gcd
	.p2align	4, 0x90
	.type	gcd,@function
gcd:
	.cfi_startproc
	pushq	%rbp			# save caller's base pointer onto the stack (prologue)
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp		# set base pointer to current stack pointer (prologue)
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp		# reserve 16 bytes on stack for local variables (alginment)
	movl	%edi, -4(%rbp)	# save argument a (in %edi) onto the stack at -4(%rbp) (4 bytes below base pointer)
	movl	%esi, -8(%rbp)	# save argument b (in %esi) onto the stack at -8(%rbp) (8 bytes below base pointer)
	movl	-4(%rbp), %edi 	# reload a from stack into %edi ready for call (redundant in unoptimised code)
	movl	-8(%rbp), %esi	# reload b from stack into %esi ready for call (redundant in unoptimised code)
	callq	gcd_recurse		# call gcd_recurse(a, b) - pushes return address and jumps to gcd_recurse
	addq	$16, %rsp		# free the 16 bytes reserved on the stack (epilogue cleanup)
	popq	%rbp			# restore the caller's base pointer (epilogue)
	.cfi_def_cfa %rsp, 8
	retq					# return to caller - return value is whatever gcd_recurse left in %eax
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
	.cfi_endproc

	.p2align	4, 0x90
	.type	gcd_recurse,@function
gcd_recurse:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jne	.LBB1_5
	cmpl	$0, -8(%rbp)
	jl	.LBB1_3
	movl	-8(%rbp), %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB1_4
.LBB1_3:
	xorl	%eax, %eax
	subl	-8(%rbp), %eax
	movl	%eax, -16(%rbp)
.LBB1_4:
	movl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB1_6
.LBB1_5:
	movl	-12(%rbp), %edi
	movl	-8(%rbp), %eax
	cltd
	idivl	-12(%rbp)
	movl	%edx, %esi
	callq	gcd_recurse
	movl	%eax, -4(%rbp)
.LBB1_6:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	gcd_recurse, .Lfunc_end1-gcd_recurse
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gcd_recurse
