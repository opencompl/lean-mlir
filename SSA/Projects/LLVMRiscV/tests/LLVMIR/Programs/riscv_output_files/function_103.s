	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	andi	a1, a1, 1
	div	a2, a0, a1
	mul	a3, a2, a1
	xor	a3, a0, a3
	slti	a0, a0, 0
	slti	a1, a1, 0
	snez	a3, a3
	xor	a0, a0, a1
	and	a0, a3, a0
	sub	a0, a2, a0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
