import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/-! # XOR   -/
def llvm_xor: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.xor  %x, %y : i64
      llvm.return %0 : i64
  }]

def xor_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64):
      %x1 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
      %x2 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> (!i64)
      %1 = xor %x1, %x2 : !i64
      %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
      llvm.return %2 : i64
  }]

  def llvm_xor_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_xor, rhs := xor_riscv, correct := by
    unfold llvm_xor xor_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp only [BitVec.setWidth_eq, BitVec.xor_eq, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    simp only [PoisonOr.toOption_getSome, InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }
