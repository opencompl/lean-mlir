import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV


/-! # UREM  -/
def llvm_urem: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.urem  %x, %y : i64
      llvm.return %1 : i64
  }]

def urem_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%reg1: i64, %reg2: i64):
      %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
      %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
      %2 = remu %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

  def llvm_urem_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_urem, rhs := urem_riscv, correct := by
    unfold llvm_urem urem_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue ht =>
      simp
    case value.value.isFalse hf =>
      simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.ofNat_eq_ofNat,
        BitVec.umod_eq, PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff,
        right_eq_ite_iff]
      bv_omega
  }

def urem_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_urem_lower_riscv]
