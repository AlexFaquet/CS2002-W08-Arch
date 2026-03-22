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
	subq	$16, %rsp		# reserve 16 bytes on stack for local variables (alignment)
	movl	%edi, -4(%rbp)	# save argument a (in %edi) onto the stack at -4(%rbp) (4 bytes below base pointer) - 32 bit int, hence movl not movq
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
	pushq	%rbp			# save caller's base pointer onto the stack (prologue)
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp		# set base pointer to current stack pointer (prologue)
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp		# reserve 16 bytes on stack for local variables (alignment)
	movl	%edi, -8(%rbp)	# save argument a (in %edi) onto the stack at -8(%rbp) (8 bytes below base pointer) - 32 bit int, hence movl not movq
	movl	%esi, -12(%rbp)	# save argument b (in %esi) onto the stack at -12(%rbp) (12 bytes below base pointer)
	cmpl	$0, -12(%rbp)	# compare b (at -12(%rbp)) with 0 - sets flags register
	jne	.LBB1_5				# if b not equal to 0, jump to else branch at .LBB1_5
	cmpl	$0, -8(%rbp)	# compares a (at -8(%rbp)) with 0 - sets flags register
	jl	.LBB1_3				# if a < 0, jump to .LBB1_3 to handle negative case
	movl	-8(%rbp), %eax	# copy a into %eax (a is non-negative)
	movl	%eax, -16(%rbp)	# temporarily store a in -16(%rbp) as staging area
	jmp	.LBB1_4				# jump to .LBB1_4, skipping the negative case
.LBB1_3:
	xorl	%eax, %eax		# set %eax to zero (XOR of anything with itself is always zero)
	subl	-8(%rbp), %eax	# subtract a from 0, computing -a (handles negative case)
	movl	%eax, -16(%rbp)	# store result -a in staging area at -16(%rbp)
.LBB1_4:
	movl	-16(%rbp), %eax	# load result from staging area at -16(%rbp) into %eax
	movl	%eax, -4(%rbp)	# store final result into return value slot at -4(%rbp)
	jmp	.LBB1_6				# jump to .LBB1_6 to return
.LBB1_5:
	movl	-12(%rbp), %edi	# load b into %edi as first argument for recursive call
	movl	-8(%rbp), %eax	# load a into %eax to prepare for division
	cltd					# sign extend %eax into %edx:%eax to prepare for idvil - idvil takes in 64 bit and each of %eax and %edx are 32 bit
	idivl	-12(%rbp)		# divide a by b - quotient goes into %eax, remainder into %edx
	movl	%edx, %esi		# copy remainder (a % b) into %esi as second argument for recursive call
	callq	gcd_recurse		# call gcd_recurse(b, a % b) recursively
	movl	%eax, -4(%rbp)	# store return value from recursive call into return value slot at -4(%rbp)
.LBB1_6:
	movl	-4(%rbp), %eax	# load return value from -4(%rbp) into %eax ready to return
	addq	$16, %rsp		# free the 16 bytes reserved on the stack (epilogue cleanup)
	popq	%rbp			# restore caller's base pointer (epilogue)
	.cfi_def_cfa %rsp, 8	
	retq					# return to caller - return value is in %eax
.Lfunc_end1:
	.size	gcd_recurse, .Lfunc_end1-gcd_recurse
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gcd_recurse
