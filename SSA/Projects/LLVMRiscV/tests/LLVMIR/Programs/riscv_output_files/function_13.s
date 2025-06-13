	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	-2293592565771025542            # 0xe02b85b6a1bdc37a
.LCPI0_1:
	.quad	-2293592565771025544            # 0xe02b85b6a1bdc378
.LCPI0_2:
	.quad	2293592565771025543             # 0x1fd47a495e423c87
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	blt	a0, a1, .LBB0_2
# %bb.1:
	mv	a0, a1
.LBB0_2:
	bgtz	a2, .LBB0_5
# %bb.3:
	lui	a3, %hi(.LCPI0_0)
	ld	a3, %lo(.LCPI0_0)(a3)
	rem	a0, a0, a1
	bgez	a2, .LBB0_6
.LBB0_4:
	div	a1, a3, a2
	addi	a1, a1, 1
	div	a0, a0, a1
	ret
.LBB0_5:
	lui	a3, %hi(.LCPI0_1)
	ld	a3, %lo(.LCPI0_1)(a3)
	rem	a0, a0, a1
	bltz	a2, .LBB0_4
.LBB0_6:
	lui	a1, %hi(.LCPI0_2)
	ld	a1, %lo(.LCPI0_2)(a1)
	div	a1, a1, a2
	neg	a1, a1
	div	a0, a0, a1
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
