	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	4587139437073004162             # 0x3fa8cb03a9ebf682
.LCPI0_1:
	.quad	4587139437073004160             # 0x3fa8cb03a9ebf680
.LCPI0_2:
	.quad	-4587139437073004161            # 0xc05734fc5614097f
.LCPI0_3:
	.quad	-861827906971256433             # 0xf40a2c15b375b98f
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	bgtz	a0, .LBB0_3
# %bb.1:
	lui	a1, %hi(.LCPI0_0)
	ld	a1, %lo(.LCPI0_0)(a1)
	blez	a0, .LBB0_4
.LBB0_2:
	div	a0, a1, a0
	addi	a0, a0, 1
	j	.LBB0_5
.LBB0_3:
	lui	a1, %hi(.LCPI0_1)
	ld	a1, %lo(.LCPI0_1)(a1)
	bgtz	a0, .LBB0_2
.LBB0_4:
	lui	a1, %hi(.LCPI0_2)
	ld	a1, %lo(.LCPI0_2)(a1)
	div	a0, a1, a0
	neg	a0, a0
.LBB0_5:
	lui	a1, %hi(.LCPI0_3)
	ld	a1, %lo(.LCPI0_3)(a1)
	remu	a0, a1, a0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
