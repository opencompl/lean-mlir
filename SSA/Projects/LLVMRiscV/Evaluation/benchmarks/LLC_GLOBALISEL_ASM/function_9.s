	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_b1p0_zmmul1p0_zba1p0_zbb1p0_zbs1p0"
	.file	"LLVMDialectModule"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	srl	a2, a0, a0
	andi	a1, a1, 1
	div	a3, a0, a2
	sltu	a2, a2, a0
	mul	a4, a0, a3
	slli	a2, a2, 63
	and	a1, a3, a1
	srai	a2, a2, 63
	or	a2, a4, a2
	sub	a0, a0, a1
	slt	a0, a0, a2
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
