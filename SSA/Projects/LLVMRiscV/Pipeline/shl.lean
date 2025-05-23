import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/-! # SHL (shift left) nsw nuw -/

def shl_llvm := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y : i64
    llvm.return %1 : i64
  }]

def shl_llvm_nsw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nsw> : i64
    llvm.return %1 : i64
  }]

def shl_llvm_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl %x, %y overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def shl_llvm_nsw_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.shl  %x, %y overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def shl_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i64) -> (!i64)
    %2 = sll %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_shl_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm
  rhs := shl_riscv
  correct := by
      unfold shl_llvm shl_riscv
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
        simp at hff
        simp
        rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
        bv_omega

def llvm_shl_lower_riscv_nsw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw
  rhs := shl_riscv
  correct := by
      unfold shl_llvm_nsw shl_riscv
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
        split
        case isTrue ht =>
          simp
        case isFalse hf =>
          simp only [Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, BitVec.not_le] at hf
          simp only [BitVec.shiftLeft_eq', Nat.sub_zero, Nat.reduceAdd, PoisonOr.toOption_getSome,
            BitVec.setWidth_eq, BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero,
            Nat.reducePow, BitVec.signExtend_eq, PoisonOr.value_isRefinedBy_value,
            InstCombine.bv_isRefinedBy_iff]
          rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
          bv_omega

def llvm_shl_lower_riscv_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nuw
  rhs := shl_riscv
  correct := by
      unfold shl_llvm_nuw shl_riscv
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
        split
        case isTrue ht =>
          simp
        case isFalse hf =>
          simp at hf
          simp [hf]
          rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
          bv_omega

def llvm_shl_lower_riscv_nsw_nuw: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := shl_llvm_nsw_nuw
  rhs := shl_riscv
  correct := by
      unfold shl_llvm_nsw_nuw shl_riscv
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
        split
        case isTrue htt =>
          simp
        case isFalse hff =>
          simp only [Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, BitVec.shiftLeft_eq',
            Nat.sub_zero, Nat.reduceAdd, PoisonOr.toOption_getSome, BitVec.setWidth_eq,
            BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero, Nat.reducePow,
            BitVec.signExtend_eq, PoisonOr.if_then_poison_isRefinedBy_iff, BitVec.not_le,
            PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
          intro x
          rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
          bv_omega
