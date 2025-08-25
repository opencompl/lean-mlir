import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

import Lean

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.sub` instruction for types: i16, i32, i64.
-/

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true


 /-! ### i16 -/

@[simp_denote]
def llvm_sub_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.sub %x, %y : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def sub_riscv_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%y) : (i16) -> (!i64)
    %2 = sub %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

def llvm_sub_lower_riscv_no_flag_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := llvm_sub_16
  rhs := sub_riscv_16

@[simp_denote]
def llvm_sub_nsw_16 := [LV| {
    ^entry (%x: i16, %y: i16 ):
    %1 = llvm.sub  %x, %y overflow<nsw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def llvm_sub_nsw_lower_riscv_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := llvm_sub_nsw_16
  rhs := sub_riscv_16

@[simp_denote]
def llvm_sub_nuw_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.sub %x, %y overflow<nuw> : i16
    llvm.return %1 : i16
  }]

def llvm_sub_nuw_lower_riscv_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := llvm_sub_nuw_16
  rhs := sub_riscv_16

@[simp_denote]
def llvm_sub_nsw_nuw_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.sub  %x, %y overflow<nsw, nuw> : i16
    llvm.return %1 : i16
  }]

def llvm_sub_nsw_nuw_lower_riscv_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := llvm_sub_nsw_nuw_16
  rhs := sub_riscv_16


 /-! ### i32 -/

@[simp_denote]
def llvm_sub_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.sub %x, %y : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def sub_riscv_32 := [LV| {
    ^entry (%x: i32, %y: i32 ):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%y) : (i32) -> (!i64)
    %2 = sub %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def llvm_sub_lower_riscv_no_flag_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := llvm_sub_32
  rhs := sub_riscv_32

@[simp_denote]
def llvm_sub_nsw_32 := [LV| {
    ^entry (%x: i32, %y: i32 ):
    %1 = llvm.sub  %x, %y overflow<nsw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def llvm_sub_nsw_lower_riscv_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := llvm_sub_nsw_32
  rhs := sub_riscv_32

@[simp_denote]
def llvm_sub_nuw_32 := [LV| {
    ^entry (%x: i32, %y: i32 ):
    %1 = llvm.sub %x, %y overflow<nuw> : i32
    llvm.return %1 : i32
  }]

def llvm_sub_nuw_lower_riscv_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := llvm_sub_nuw_32
  rhs := sub_riscv_32

@[simp_denote]
def llvm_sub_nsw_nuw_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.sub  %x, %y overflow<nsw, nuw> : i32
    llvm.return %1 : i32
  }]

def llvm_sub_nsw_nuw_lower_riscv_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := llvm_sub_nsw_nuw_32
  rhs := sub_riscv_32


/-! ### i64 -/

@[simp_denote]
def llvm_sub_self_64 := [LV| {
    ^entry (%x: i64 ):
    %1 = llvm.sub %x, %x : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sub_riscv_self_64 := [LV| {
    ^entry (%x: i64):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %2 = sub %0, %0 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag_self_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_self_64
  rhs := sub_riscv_self_64


@[simp_denote]
def llvm_sub_64 := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sub %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sub_riscv_64 := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> (!i64)
    %2 = sub %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_64
  rhs := sub_riscv_64

@[simp_denote]
def llvm_sub_nsw_64 := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sub  %x, %y overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def llvm_sub_nsw_lower_riscv_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nsw_64
  rhs := sub_riscv_64

@[simp_denote]
def llvm_sub_nuw_64 := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sub %x, %y overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_sub_nuw_lower_riscv_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nuw_64
  rhs := sub_riscv_64

@[simp_denote]
def llvm_sub_nsw_nuw_64 := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sub  %x, %y overflow<nsw, nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_sub_nsw_nuw_lower_riscv_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nsw_nuw_64
  rhs := sub_riscv_64

def sub_match_64: List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_lower_riscv_no_flag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_lower_riscv_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nuw_lower_riscv_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_nuw_lower_riscv_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_lower_riscv_no_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nuw_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_nuw_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_lower_riscv_no_flag_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_lower_riscv_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nuw_lower_riscv_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_sub_nsw_nuw_lower_riscv_64)
]
