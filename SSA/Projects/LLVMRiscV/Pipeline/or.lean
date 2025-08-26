import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.or` instruction for types i8, i16, i32, i64.
-/

/-! ### i8 -/

@[simp_denote]
def or_llvm_noflag_8 := [LV| {
  ^entry (%x: i8, %y: i8):
    %0 = llvm.or %x, %y : i8
    llvm.return %0 : i8
  }]

@[simp_denote]
def or_riscv_8 := [LV| {
  ^entry (%r1: i8, %r2: i8):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i8) -> (!i64)
    %2 = or %0, %1 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i8)
    llvm.return %3 : i8
  }]

def llvm_or_lower_riscv_noflag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := or_llvm_noflag_8
  rhs := or_riscv_8

@[simp_denote]
def or_llvm_disjoint_8 := [LV| {
  ^entry (%x: i8, %y: i8):
    %1 = llvm.or disjoint %x, %y : i8
    llvm.return %1 : i8
  }]

def llvm_or_lower_riscv_disjoint_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := or_llvm_disjoint_8
  rhs := or_riscv_8


/-! ### i16 -/

@[simp_denote]
def or_llvm_noflag_16 := [LV| {
  ^entry (%x: i16, %y: i16):
    %0 = llvm.or %x, %y : i16
    llvm.return %0 : i16
  }]

@[simp_denote]
def or_riscv_16 := [LV| {
  ^entry (%r1: i16, %r2: i16):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i16) -> (!i64)
    %2 = or %0, %1 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

def llvm_or_lower_riscv_noflag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := or_llvm_noflag_16
  rhs := or_riscv_16

@[simp_denote]
def or_llvm_disjoint_16 := [LV| {
  ^entry (%x: i16, %y: i16):
    %1 = llvm.or disjoint %x, %y : i16
    llvm.return %1 : i16
  }]

def llvm_or_lower_riscv_disjoint_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := or_llvm_disjoint_16
  rhs := or_riscv_16


/-! ### i32 -/

@[simp_denote]
def or_llvm_noflag_32 := [LV| {
  ^entry (%x: i32, %y: i32):
    %0 = llvm.or %x, %y : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def or_riscv_32 := [LV| {
  ^entry (%r1: i32, %r2: i32):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i32) -> (!i64)
    %2 = or %0, %1 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

def llvm_or_lower_riscv_noflag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := or_llvm_noflag_32
  rhs := or_riscv_32

@[simp_denote]
def or_llvm_disjoint_32 := [LV| {
  ^entry (%x: i32, %y: i32 ):
    %1 = llvm.or disjoint %x, %y : i32
    llvm.return %1 : i32
  }]

def llvm_or_lower_riscv_disjoint_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := or_llvm_disjoint_32
  rhs := or_riscv_32


/-! ### i64 -/

@[simp_denote]
def or_llvm_noflag_64 := [LV| {
  ^entry (%x: i64, %y: i64):
    %0 = llvm.or %x, %y : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def or_riscv_64 := [LV| {
  ^entry (%r1: i64, %r2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> (!i64)
    %2 = or %0, %1 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_or_lower_riscv_noflag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := or_llvm_noflag_64
  rhs := or_riscv_64

@[simp_denote]
def or_llvm_disjoint_64 := [LV| {
  ^entry (%x: i64, %y: i64 ):
    %1 = llvm.or disjoint %x, %y : i64
    llvm.return %1 : i64
  }]

def llvm_or_lower_riscv_disjoint_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := or_llvm_disjoint_64
  rhs := or_riscv_64

def or_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_noflag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_disjoint_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_noflag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_disjoint_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_noflag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_disjoint_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_noflag_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_or_lower_riscv_disjoint_64)
]
