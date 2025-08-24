import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

import Lean

open LLVMRiscV

/-
Disabled due to simproc implementation not being re-evaluated correctly
on Lean version "4.20.0-nightly-2025-04-21" -/
set_option Elab.async true

@[simp_denote]
def llvm_sub_self := [LV| {
    ^entry (%x: i64 ):
    %1 = llvm.sub %x, %x : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sub_riscv_self := [LV| {
    ^entry (%x: i64):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %2 = sub %0, %0 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag_self: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_self
  rhs := sub_riscv_self

 /-! # SUB i64 -/

@[simp_denote]
def llvm_sub := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sub %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def sub_riscv := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> (!i64)
    %2 = sub %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_sub_lower_riscv_no_flag: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub
  rhs := sub_riscv

/-! # SUB i64, flags  -/
@[simp_denote]
def llvm_sub_nsw := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sub  %x, %y overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def llvm_sub_nsw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nsw
  rhs := sub_riscv

@[simp_denote]
def llvm_sub_nuw := [LV| {
    ^entry (%x: i64, %y: i64 ):
    %1 = llvm.sub %x, %y overflow<nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_sub_nuw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nuw
  rhs := sub_riscv

@[simp_denote]
def llvm_sub_nsw_nuw := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.sub  %x, %y overflow<nsw, nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_sub_nsw_nuw_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_nsw_nuw
  rhs := sub_riscv

def sub_match: List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
   List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_sub_lower_riscv_no_flag, llvm_sub_nsw_lower_riscv,
   llvm_sub_nuw_lower_riscv, llvm_sub_nsw_nuw_lower_riscv ]
  ++
  [ mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  llvm_sub_lower_riscv_no_flag_self)]

 /-! # SUB i32 -/

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

/-! # SUB i32, flags  -/
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

def sub_match_32: List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
   List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_sub_lower_riscv_no_flag_32, llvm_sub_nsw_lower_riscv_32,
   llvm_sub_nuw_lower_riscv_32, llvm_sub_nsw_nuw_lower_riscv_32 ]

 /-! # SUB i16 -/

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

/-! # SUB, flags  -/
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

def sub_match_16: List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
   List.map (fun x =>  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_sub_lower_riscv_no_flag_16, llvm_sub_nsw_lower_riscv_16,
  llvm_sub_nuw_lower_riscv_16, llvm_sub_nsw_nuw_lower_riscv_16]
