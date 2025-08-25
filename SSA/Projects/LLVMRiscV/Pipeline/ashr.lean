import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.ashr` instruction for types i8, i16, i32, i64.
-/

/-! ### i8 -/

@[simp_denote]
def ashr_llvm_no_flag_8 := [LV| {
  ^entry (%x: i8, %amount: i8):
    %1 = llvm.ashr %x, %amount : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def ashr_llvm_exact_flag_8 := [LV| {
  ^entry (%x: i8, %amount: i8):
    %1 = llvm.ashr exact %x, %amount : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def ashr_riscv_8 := [LV| {
  ^entry (%x: i8, %amount: i8):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i8) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i8) -> (!i64)
    %res = sra %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i8)
    llvm.return %y : i8
  }]

def llvm_ashr_lower_riscv_no_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := ashr_llvm_no_flag_8
  rhs := ashr_riscv_8

def llvm_ashr_lower_riscv_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := ashr_llvm_exact_flag_8
  rhs := ashr_riscv_8


/-! ### i16 -/

@[simp_denote]
def ashr_llvm_no_flag_16 := [LV| {
  ^entry (%x: i16, %amount: i16):
    %1 = llvm.ashr %x, %amount : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def ashr_llvm_exact_flag_16 := [LV| {
  ^entry (%x: i16, %amount: i16):
    %1 = llvm.ashr exact %x, %amount : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def ashr_riscv_16 := [LV| {
  ^entry (%x: i16, %amount: i16):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i16) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i16) -> (!i64)
    %res = sra %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i16)
    llvm.return %y : i16
  }]

def llvm_ashr_lower_riscv_no_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := ashr_llvm_no_flag_16
  rhs := ashr_riscv_16

def llvm_ashr_lower_riscv_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := ashr_llvm_exact_flag_16
  rhs := ashr_riscv_16


/-! ### i32 -/

@[simp_denote]
def ashr_llvm_no_flag_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %1 = llvm.ashr %x, %amount : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def ashr_llvm_exact_flag_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %1 = llvm.ashr exact %x, %amount : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def ashr_riscv_32 := [LV| {
  ^entry (%x: i32, %amount: i32):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i32) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i32) -> (!i64)
    %res = sra %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i32)
    llvm.return %y : i32
  }]

def llvm_ashr_lower_riscv_no_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := ashr_llvm_no_flag_32
  rhs := ashr_riscv_32

def llvm_ashr_lower_riscv_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := ashr_llvm_exact_flag_32
  rhs := ashr_riscv_32


/-! ### i64 -/

@[simp_denote]
def ashr_llvm_no_flag_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def ashr_llvm_exact_flag_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %1 = llvm.ashr exact %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def ashr_riscv_64 := [LV| {
  ^entry (%x: i64, %amount: i64):
    %base = "builtin.unrealized_conversion_cast" (%x) : (i64) -> (!i64)
    %shamt = "builtin.unrealized_conversion_cast" (%amount) : (i64) -> (!i64)
    %res = sra %base, %shamt : !i64
    %y= "builtin.unrealized_conversion_cast" (%res) : (!i64) -> (i64)
    llvm.return %y : i64
  }]

def llvm_ashr_lower_riscv_no_flag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := ashr_llvm_no_flag_64
  rhs := ashr_riscv_64

def llvm_ashr_lower_riscv_flag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := ashr_llvm_exact_flag_64
  rhs := ashr_riscv_64

def ashr_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_no_flag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_flag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_no_flag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_flag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_no_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_no_flag_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_ashr_lower_riscv_flag_64)
]
