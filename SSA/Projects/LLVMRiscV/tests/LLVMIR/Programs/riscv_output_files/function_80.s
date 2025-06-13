	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_zmmul1p0"
	.file	"LLVMDialectModule"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	2026955581972156870             # 0x1c21315ccef211c6
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	lui	a2, %hi(.LCPI0_0)
	ld	a2, %lo(.LCPI0_0)(a2)
	slti	a3, a1, 0
	and	a0, a0, a2
	div	a2, a0, a1
	mul	a1, a2, a1
	xor	a1, a0, a1
	slti	a0, a0, 0
	snez	a1, a1
	xor	a0, a0, a3
	and	a0, a1, a0
	sub	a0, a2, a0
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
