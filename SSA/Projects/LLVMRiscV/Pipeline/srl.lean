import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/-
Removing bitvec lemmas from the simp-set that simplify bitvector operations into toNat operations.
-/
attribute [-simp] BitVec.ushiftRight_eq' BitVec.shiftLeft_eq' BitVec.sshiftRight_eq'

/- # SRL, not exact
Logical right shift operation in LLVM: if exact flag is set,
then returns poison if any non zero bit is shifted  -/

def lshr_llvm_no_flag := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr %x, %amount : i64
    llvm.return %1 : i64
  }]

def srl_riscv := [LV| {
    ^entry (%x: i64, %amount: i64 ):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i64) -> (!i64)
    %res = srl %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
    llvm.return %y : i64
  }]

def llvm_srl_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_no_flag
  rhs := srl_riscv
  correct :=  by
    unfold lshr_llvm_no_flag srl_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp only [LLVM.lshr?, Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, Nat.sub_zero,
      Nat.reduceAdd, BitVec.setWidth_eq, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue htt =>
      simp
    case value.value.isFalse hff =>
      simp at hff
      simp
      bv_decide

def lshr_llvm_exact := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.lshr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

def llvm_srl_lower_riscv_exact : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := lshr_llvm_exact
  rhs := srl_riscv
  correct := by
    unfold lshr_llvm_exact srl_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue htt =>
        simp
    case value.value.isFalse hff =>
      split
      case isTrue ht =>
        simp
      case isFalse hf =>
        simp
        bv_decide
