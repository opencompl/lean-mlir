import SSA.Projects.RISCV64.Pipeline.alltoolchain
open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

-- done
/-! # XOR   -/
def llvm_xor: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.xor  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def xor_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %x1 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %x2 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> !i64
      %1 =  xor %x1, %x2 : !i64 -- value depends on wether to no overflow flag is present or not
      %2 = "builtin.unrealized_conversion_cast" (%1) : (!i64) -> (i64)
      llvm.return %2 : i64
  }]

  def llvm_xor_lower_riscv: LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_xor , rhs := xor_riscv, correct := by
    unfold llvm_xor xor_riscv
    simp_peephole
    rintro (_|a) (_|b) <;> simp only [LLVM.xor, LLVM.xor?, Option.bind_eq_bind, Option.some_bind]
    . simp
    . simp
    . simpa
    . simp [BitVec.Refinement , RTYPE_pure64_RISCV_XOR , builtin.unrealized_conversion_cast.riscvToLLVM, builtin.unrealized_conversion_cast.LLVMToriscv]
      bv_decide
  }
