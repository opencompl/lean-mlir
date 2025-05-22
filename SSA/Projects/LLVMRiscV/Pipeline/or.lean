import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.Pipeline.simpproc
import SSA.Projects.LLVMRiscV.Pipeline.simpriscv
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/-- This file contains lowering of the llvm or instruction -/

/- # OR non-disjoint  -/

def or_llvm_noflag : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %0 = llvm.or  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %0 : i64
  }]

def or_riscv := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> !i64
      %2 = or %0, %1 : !i64
      %3= "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_or_lower_riscv1_noflag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := or_llvm_noflag , rhs := or_riscv ,
    correct :=  by
      unfold or_llvm_noflag or_riscv
      simp_peephole
      simp_riscv
      simp_alive_undef
      simp_alive_case_bash
      simp_alive_split
      all_goals
      simp
      bv_decide
}

/-! # OR disjoint-/

/- the disjoint flag requries that no two bits at the same index are set in either of the dialects.
This allows an or to be treated as an addition.  -/
def or_llvm_disjoint : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.or disjoint   %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_or_lower_riscv_disjoint : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := or_llvm_disjoint , rhs := or_riscv ,
    correct :=  by
      unfold or_llvm_disjoint or_riscv
      simp_peephole
      simp_riscv
      simp_alive_undef
      simp_alive_case_bash
      simp_alive_split
      all_goals
      simp
      bv_decide
}
