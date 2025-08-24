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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	andi	a0, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_2
# %bb.1:
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB0_2:
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	xor	a0, a0, a1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
