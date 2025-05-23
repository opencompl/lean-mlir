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

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

def llvm_sub_self: Com  LLVMPlusRiscV [.llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64 ):
      %1 = llvm.sub  %x, %x : i64
      llvm.return %1 : i64
  }]

def sub_riscv_self: Com  LLVMPlusRiscV [.llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64):
      %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %2 = sub %0, %0 : !i64
      %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag_self: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_sub_self , rhs := sub_riscv_self, correct := by
    unfold llvm_sub_self sub_riscv_self
    simp_peephole
    simp_riscv
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp [LLVM.sub, LLVM.sub?]

  }

def llvm_sub: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sub  %x, %y : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def sub_riscv: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> !i64
      %1 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> !i64
      %2 = sub %0, %1 : !i64 -- value depends on wether to no overflow flag is present or not
      %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
      llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_sub , rhs := sub_riscv, correct := by
        unfold llvm_sub sub_riscv
        simp_peephole
        simp [LLVM.sub, castriscvToLLVM, RTYPE_pure64_RISCV_SUB,castLLVMToriscv, LLVM.sub?]
        simp_alive_case_bash
        simp_alive_split
        simp
      }

/-! # SUB, flags  -/

def llvm_sub_nsw: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sub  %x, %y overflow<nsw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]

def llvm_sub_nsw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_sub_nsw , rhs := sub_riscv, correct := by
     unfold llvm_sub_nsw sub_riscv
     simp_peephole
     simp [LLVM.sub, castriscvToLLVM, RTYPE_pure64_RISCV_SUB,castLLVMToriscv, LLVM.sub?]
     simp_alive_case_bash
     simp_alive_split
     simp
  }

def llvm_sub_nuw: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sub  %x, %y overflow<nuw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
-- siubtraction with no unsigned overflow flag
def llvm_sub_nuw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_sub_nuw , rhs := sub_riscv, correct := by
    unfold llvm_sub_nuw sub_riscv
    simp_peephole
    simp_riscv
    --simp_alive_ops
    simp [LLVM.sub, LLVM.sub?]
    simp_alive_case_bash
    simp_alive_split
    simp
    }

def llvm_sub_nsw_nuw: Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)]
    .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%x: i64, %y: i64 ):
      %1 = llvm.sub  %x, %y overflow<nsw, nuw> : i64 -- value depends on wether to no overflow flag is present or not
      llvm.return %1 : i64
  }]
def llvm_sub_nsw_nuw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_sub_nsw_nuw, rhs := sub_riscv, correct := by
    unfold llvm_sub_nsw_nuw sub_riscv --unfolding
    simp_peephole -- call simp_peephole function --> need to think how much it depends on the simp_peephole implementation
    simp_riscv
    simp [LLVM.sub, LLVM.sub?]
    simp_alive_case_bash
    simp_alive_split
    simp
  }
