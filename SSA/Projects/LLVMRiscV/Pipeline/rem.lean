import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.rem` instruction for types i8, i16, i32, i64.
-/

/-! ### i8 -/

@[simp_denote]
def rem_llvm_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.srem %x, %y : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def rem_riscv_8 := [LV| {
    ^entry (%reg1: i8, %reg2: i8):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i8) -> (!i64)
    %2 = rem  %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i8)
    llvm.return %3 : i8
  }]

def llvm_rem_lower_riscv_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := rem_llvm_8
  rhs := rem_riscv_8
  correct := by sorry

/-! ### i16 -/

@[simp_denote]
def rem_llvm_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.srem %x, %y : i16
    llvm.return %1 : i16
  }]
@[simp_denote]
def rem_riscv_16 := [LV| {
    ^entry (%reg1: i16, %reg2: i16):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i16) -> (!i64)
    %2 = rem  %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

def llvm_rem_lower_riscv_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := rem_llvm_16
  rhs := rem_riscv_16
  correct := by sorry


/-! ### i32 -/

@[simp_denote]
def rem_llvm_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.srem %x, %y : i32
    llvm.return %1 : i32
  }]
@[simp_denote]
def rem_riscv_32 := [LV| {
    ^entry (%reg1: i32, %reg2: i32):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i32) -> (!i64)
    %2 = rem  %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def llvm_rem_lower_riscv_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := rem_llvm_32
  rhs := rem_riscv_32
  correct := by sorry


/-! ### i64 -/

@[simp_denote]
def rem_llvm_64 := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.srem %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def rem_riscv_64 := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i64) -> (!i64)
    %2 = rem  %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_rem_lower_riscv_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := rem_llvm_64
  rhs := rem_riscv_64

def rem_match_64 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_rem_lower_riscv_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_rem_lower_riscv_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_rem_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_rem_lower_riscv_64)
]
