	.text
	.file	"gcd.c"
	.globl	gcd
	.p2align	4, 0x90
	.type	gcd,@function
gcd:
	.cfi_startproc
	pushq	%rbp				# save caller's base pointer onto the stack (prologue)
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp			# set base pointer to current stack pointer (prologue)
	.cfi_def_cfa_register %rbp
	movl	%edi, %eax			# copy a into %eax - preserves a for later use
	testl	%esi, %esi			# test if b is zero by ANDing %esi with itself, 
								# can only be zero if every single bit in the result is 0 - sets flag register
	je	.LBB0_1					# if b is zero, jump to base case at .LBB0_1
	movl	%esi, %edx			# copy b into %edx - %edx will track current b through the loop
	.p2align	4, 0x90
.LBB0_3:
	movl	%edx, %ecx			# copy b into %ecx to preserve it before cltd overwrites %edx
	cltd						# sign extend %eax into %edx:%eax to prepare for idivl
	idivl	%ecx				# divide a by b - quotient goes into %eax, remainder goes into %edx
	movl	%ecx, %eax			# new a = old b (update for next iteration)
	testl	%edx, %edx			# test if remainder (new b) is zero - sets flag register
	jne	.LBB0_3					# if remainder is not zero, loop back and repeat
	jmp	.LBB0_4					# if remainder is zero - algorithm complete, jump to end
.LBB0_1:
	movl	%eax, %ecx			# b was zero from the start - copy a into %ecx to preserve it before negl overwrites it
.LBB0_4:
	movl	%ecx, %eax			# load result into %eax ready for absolute value check
	negl	%eax				# negate %eax - also sets sign flag as side effect
	cmovsl	%ecx, %eax			# if sign flag set (result was positive), restore original value from %ecx
	popq	%rbp				# restore caller's base pointer (epilogue)
	.cfi_def_cfa %rsp, 8
	retq						# return to caller - absolute value of result is in %eax
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
	.cfi_endproc

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
