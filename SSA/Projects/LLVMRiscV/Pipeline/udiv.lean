import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

import Lean

open LLVMRiscV
open RV64Semantics
open InstCombine(LLVM)

/-! # UDIV no exact  -/

def udiv_llvm_no_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.udiv  %x, %y : i64
      llvm.return %1 : i64
  }]

def udiv_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> !i64
      %2 = divu  %0, %1 : !i64
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_udiv_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_no_exact , rhs := udiv_riscv, correct := by
    unfold udiv_llvm_no_exact udiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp only [LLVM.udiv?, BitVec.ofNat_eq_ofNat, BitVec.setWidth_eq, BitVec.reduceNeg,
      BitVec.udiv_eq, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue ht =>
      simp
    case value.value.isFalse hf =>
      simp [hf]
      }

/-! # UDIV exact   -/

def udiv_llvm_exact : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %0 = llvm.udiv exact  %x, %y : i64
      llvm.return %0 : i64
  }]

def llvm_udiv_lower_riscv_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := udiv_llvm_exact, rhs := udiv_riscv, correct := by
    unfold udiv_llvm_exact udiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp only [BitVec.umod_eq, BitVec.ofNat_eq_ofNat, ne_eq, true_and, LLVM.udiv?, ite_not,
      BitVec.setWidth_eq, BitVec.reduceNeg, BitVec.udiv_eq, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue ht =>
      split
      case isTrue ht =>
        simp
      case isFalse hf =>
        simp only [PoisonOr.toOption_getSome, PoisonOr.value_isRefinedBy_value,
          InstCombine.bv_isRefinedBy_iff, right_eq_ite_iff]
        simp [hf]
    case value.value.isFalse hf =>
        simp [hf]
    }
