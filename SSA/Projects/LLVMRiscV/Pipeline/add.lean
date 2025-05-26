import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

open LLVMRiscV

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

/- # ADD, RiscV  -/
def add_riscv := [LV| {
  ^entry (%lhs: i64, %rhs: i64):
    %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
    %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i64) -> (!i64)
    %add1 = add %lhsr, %rhsr : !i64
    %addl = "builtin.unrealized_conversion_cast" (%add1) : (!i64) -> (i64)
    llvm.return %addl : i64
  }]

/- # ADD, no flag  -/
def add_llvm_no_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs : i64
    llvm.return %1 : i64
  }]

/- # ADD, with flags  -/
def add_llvm_nsw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nsw> : i64
    llvm.return %1 : i64
  }]

def add_llvm_nuw_flags := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def add_llvm_nsw_nuw_flags := [LV| {
   ^entry (%lhs: i64, %rhs: i64):
    %1 = llvm.add %lhs, %rhs overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_add_lower_riscv_noflags : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_no_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_no_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

def llvm_add_lower_riscv_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nsw_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_nsw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

def llvm_add_lower_riscv_nuw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nuw_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_nuw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

def llvm_add_lower_riscv_nuw_nsw_flag : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= add_llvm_nuw_flags
  rhs:= add_riscv
  correct := by
    unfold add_llvm_nuw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp
