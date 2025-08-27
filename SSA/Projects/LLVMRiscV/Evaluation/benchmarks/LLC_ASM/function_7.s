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
	add	a2, a0, a0
	slli	a1, a1, 63
	srai	a1, a1, 63
	and	a0, a1, a0
	sltu	a1, a2, a0
	neg	a1, a1
	mul	a0, a0, a2
	sll	a1, a1, a0
	slt	a0, a1, a0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
