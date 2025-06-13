	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	3220996587549851491             # 0x2cb34754afa77f63
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	lui	a1, %hi(.LCPI0_0)
	ld	a1, %lo(.LCPI0_0)(a1)
	slti	a2, a0, 0
	sgtz	a3, a0
	div	a4, a1, a0
	mul	a5, a4, a0
	xor	a1, a5, a1
	snez	a1, a1
	and	a1, a1, a2
	sub	a1, a4, a1
	srl	a2, a1, a1
	and	a4, a2, a0
	sgtz	a5, a2
	slti	a4, a4, 0
	and	a5, a5, a3
	or	a4, a4, a5
	bnez	a4, .LBB0_2
# %bb.1:
	neg	a3, a2
	div	a0, a3, a0
	neg	a0, a0
	bgeu	a0, a2, .LBB0_3
	j	.LBB0_4
.LBB0_2:
	neg	a3, a3
	ori	a3, a3, 1
	add	a3, a3, a2
	div	a0, a3, a0
	addi	a0, a0, 1
	bltu	a0, a2, .LBB0_4
.LBB0_3:
	mv	a0, a2
.LBB0_4:
	or	a0, a0, a1
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
