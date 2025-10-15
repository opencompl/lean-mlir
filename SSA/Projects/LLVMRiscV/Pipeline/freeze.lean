import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.freeze` instruction for types i8, i16, i32, i64.
-/

/-! ### i8 -/

@[simp_denote]
def freeze_llvm_8 := [LV| {
  ^entry (%x: i8):
    %0 = llvm.freeze %x: i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def freeze_riscv_8 := [LV| {
  ^entry (%r1: i8):
    llvm.return %r1 : i8
  }]

def llvm_freeze_lower_riscv_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := freeze_llvm_8
  rhs := freeze_riscv_8

/-! ### i16 -/

@[simp_denote]
def freeze_llvm_16 := [LV| {
  ^entry (%x: i16):
    %0 = llvm.freeze %x: i16
    llvm.return %0 : i16
  }]

@[simp_denote]
def freeze_riscv_16 := [LV| {
  ^entry (%r1: i16):
    llvm.return %r1 : i16
  }]

def llvm_freeze_lower_riscv_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := freeze_llvm_16
  rhs := freeze_riscv_16

/-! ### i32 -/

@[simp_denote]
def freeze_llvm_32 := [LV| {
  ^entry (%x: i32):
    %0 = llvm.freeze %x: i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def freeze_riscv_32 := [LV| {
  ^entry (%r1: i32):
    llvm.return %r1 : i32
  }]

def llvm_freeze_lower_riscv_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := freeze_llvm_32
  rhs := freeze_riscv_32

/-! ### i64 -/

@[simp_denote]
def freeze_llvm_64 := [LV| {
  ^entry (%x: i64):
    %0 = llvm.freeze %x: i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def freeze_riscv_64 := [LV| {
  ^entry (%r1: i64):
    llvm.return %r1 : i64
  }]

def llvm_freeze_lower_riscv_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := freeze_llvm_64
  rhs := freeze_riscv_64

def freeze_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_freeze_lower_riscv_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_freeze_lower_riscv_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_freeze_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_freeze_lower_riscv_64)
]
