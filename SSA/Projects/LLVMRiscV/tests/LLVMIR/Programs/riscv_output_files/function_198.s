	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	-382332001542543107             # 0xfab1af11fdcae8fd
.LCPI0_1:
	.quad	-1629065603047637384            # 0xe96465771689be78
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	andi	a1, a1, 1
	bnez	a1, .LBB0_2
# %bb.1:
	mv	a1, a0
	bge	a0, a0, .LBB0_3
	j	.LBB0_4
.LBB0_2:
	lui	a1, %hi(.LCPI0_0)
	ld	a1, %lo(.LCPI0_0)(a1)
	blt	a0, a1, .LBB0_4
.LBB0_3:
	mv	a0, a1
.LBB0_4:
	lui	a1, %hi(.LCPI0_1)
	ld	a1, %lo(.LCPI0_1)(a1)
	divu	a0, a1, a0
	addi	a0, a0, 1
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
