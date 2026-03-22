	.text
	.file	"gcd.c"
	.globl	gcd
	.p2align	2
	.type	gcd,@function
gcd:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	gcd_recurse
	ldp	x29, x30, [sp], #16
	ret
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
	.cfi_endproc

	.p2align	2
	.type	gcd_recurse,@function
gcd_recurse:
	.cfi_startproc
	cbz	w1, .LBB1_2
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sdiv	w8, w0, w1
	msub	w8, w8, w1, w0
	mov	w0, w1
	mov	w1, w8
	bl	gcd_recurse
	ldp	x29, x30, [sp], #16
	ret
.LBB1_2:
	cmp	w0, #0
	cneg	w0, w0, mi
	ret
.Lfunc_end1:
	.size	gcd_recurse, .Lfunc_end1-gcd_recurse
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
