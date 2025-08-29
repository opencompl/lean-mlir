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
	add	a3, a0, a0
	andi	a1, a1, 1
	xor	a2, a2, a2
	bnez	a1, .LBB0_2
# %bb.1:
	mv	a0, a2
.LBB0_2:
	srl	a0, a0, a2
	sltu	a1, a3, a0
	slli	a1, a1, 63
	srai	a1, a1, 63
	mul	a0, a0, a3
	sll	a1, a1, a0
	slt	a0, a1, a0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
