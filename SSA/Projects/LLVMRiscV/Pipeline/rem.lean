import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/-! # REM -/

/-- This file contains the lowerings for the llvm rem instruction.
We take the diffrent possible flags into account. -/

def rem_llvm := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.srem %x, %y : i64
    llvm.return %1 : i64
  }]

def rem_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i64) -> (!i64)
    %2 = rem  %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_rem_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := rem_llvm
  rhs := rem_riscv
  correct := by
    unfold rem_llvm rem_riscv
    simp_peephole
    simp_alive_undef
    simp_alive_ops
    simp_riscv
    simp_alive_case_bash
    intro x x'
    simp_alive_split
    simp
