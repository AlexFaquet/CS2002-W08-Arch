	.text
	.file	"gcd.c"
	.globl	gcd
	.p2align	2
	.type	gcd,@function
gcd:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!	// save frame pointer (x29, equivalent to %rbp in x86) and return address (x30) to stack, decrement sp by 16 (prologue)
	mov	x29, sp					// set frame pointer x29 to current stack pointer - establishes stack frame (prologue)
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	gcd_recurse				// call gcd_recurse(a, b) - saves return address in x30 and jumps to gcd_recurse
	ldp	x29, x30, [sp], #16		// restore frame pointer (x29) and return address (x30) from stack, increment sp by 16 (epilogue)
	ret							// return to caller - jumps to address stored in link register x30
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
	.cfi_endproc

	.p2align	2
	.type	gcd_recurse,@function
gcd_recurse:
	.cfi_startproc
	cbz	w1, .LBB1_2				// if b (w1) is zero, jump to base case at .LBB1_2 - otherwise, carry on with prologue
	stp	x29, x30, [sp, #-16]!	// b is not zero - save frame pointer and return address before recursive call overwrites x30 (prologue)
	mov	x29, sp					// set frame pointer x29 to current stack pointer - establishes stack frame (prologue)
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sdiv	w8, w0, w1			// compute quotient of a / b, store in w8
	msub	w8, w8, w1, w0		// compute remainder: a - (quotient * b) = a % b, store in w8
	mov	w0, w1					// set first argument for recursive call - new a = old b
	mov	w1, w8					// set second argument for recursive call - new b = a % b (remainder from division)
	bl	gcd_recurse				// call gcd_recurse(b, a % b) recursively - saves return address in x30
	ldp	x29, x30, [sp], #16		// restore frame pointer and return address from stack, increment sp by 16 (epilogue)
	ret							// return to caller - jumps to address stored in link register in x30
.LBB1_2:
	cmp	w0, #0					// compare a (w0) with 0 - sets flag register
	cneg	w0, w0, mi			// if a is negative (mi = minus), negate w0 to get absolute value
	ret							// return to caller - absolute value of result is in w0
.Lfunc_end1:
	.size	gcd_recurse, .Lfunc_end1-gcd_recurse
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
