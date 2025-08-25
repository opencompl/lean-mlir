import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.mul` instruction for types i8, i16, i32, i64.
-/

/-! ### i8 -/

@[simp_denote]
def mul_riscv_8 := [LV| {
    ^entry (%r1: i8, %r2: i8 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i8) -> (!i64)
    %2 = mul  %1, %0 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i8)
    llvm.return %3 : i8
  }]

@[simp_denote]
def mul_llvm_noflag_8 := [LV| {
    ^entry (%x: i8, %amount: i8):
    %1 = llvm.mul %x, %amount : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def mul_llvm_nsw_8 := [LV| {
    ^entry (%x: i8, %amount: i8):
    %1 = llvm.mul %x, %amount overflow<nsw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def mul_llvm_nuw_8 := [LV| {
    ^entry (%x: i8, %amount: i8):
    %1 = llvm.mul %x, %amount overflow<nuw> : i8
    llvm.return %1 : i8
  }]

@[simp_denote]
def mul_llvm_flags_8 := [LV| {
    ^entry (%x: i8, %amount: i8):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i8
    llvm.return %1 : i8
  }]

def llvm_mul_lower_riscv_noflag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := mul_llvm_noflag_8
  rhs := mul_riscv_8

def llvm_mul_lower_riscv_flags_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := mul_llvm_flags_8
  rhs := mul_riscv_8

def llvm_mul_lower_riscv_nsw_flag_8: LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := mul_llvm_nsw_8
  rhs := mul_riscv_8

def llvm_mul_lower_riscv_nuw_flag_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
  lhs := mul_llvm_nuw_8
  rhs := mul_riscv_8


/-! ### i16-/

@[simp_denote]
def mul_riscv_16 := [LV| {
    ^entry (%r1: i16, %r2: i16 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i16) -> (!i64)
    %2 = mul  %1, %0 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

@[simp_denote]
def mul_llvm_noflag_16 := [LV| {
    ^entry (%x: i16, %amount: i16):
    %1 = llvm.mul %x, %amount : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def mul_llvm_nsw_16 := [LV| {
    ^entry (%x: i16, %amount: i16):
    %1 = llvm.mul %x, %amount overflow<nsw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def mul_llvm_nuw_16 := [LV| {
    ^entry (%x: i16, %amount: i16):
    %1 = llvm.mul %x, %amount overflow<nuw> : i16
    llvm.return %1 : i16
  }]

@[simp_denote]
def mul_llvm_flags_16 := [LV| {
    ^entry (%x: i16, %amount: i16):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i16
    llvm.return %1 : i16
  }]

def llvm_mul_lower_riscv_noflag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := mul_llvm_noflag_16
  rhs := mul_riscv_16

def llvm_mul_lower_riscv_flags_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := mul_llvm_flags_16
  rhs := mul_riscv_16

def llvm_mul_lower_riscv_nsw_flag_16: LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := mul_llvm_nsw_16
  rhs := mul_riscv_16

def llvm_mul_lower_riscv_nuw_flag_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
  lhs := mul_llvm_nuw_16
  rhs := mul_riscv_16


/-! ### i32-/

@[simp_denote]
def mul_riscv_32 := [LV| {
    ^entry (%r1: i32, %r2: i32 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i32) -> (!i64)
    %2 = mul  %1, %0 : !i64 -- this is because the semanitcs specify mul rs1 rs2 to be passed as multiplication rs2 rs1 which is defined as rs2 * rs1, hence to keep correct assembly syntax and semanitcs.
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

@[simp_denote]
def mul_llvm_noflag_32 := [LV| {
    ^entry (%x: i32, %amount: i32):
    %1 = llvm.mul %x, %amount : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def mul_llvm_nsw_32 := [LV| {
    ^entry (%x: i32, %amount: i32):
    %1 = llvm.mul %x, %amount overflow<nsw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def mul_llvm_nuw_32 := [LV| {
    ^entry (%x: i32, %amount: i32):
    %1 = llvm.mul %x, %amount overflow<nuw> : i32
    llvm.return %1 : i32
  }]

@[simp_denote]
def mul_llvm_flags_32 := [LV| {
    ^entry (%x: i32, %amount: i32):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i32
    llvm.return %1 : i32
  }]

def llvm_mul_lower_riscv_noflag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := mul_llvm_noflag_32
  rhs := mul_riscv_32

def llvm_mul_lower_riscv_flags_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := mul_llvm_flags_32
  rhs := mul_riscv_32

def llvm_mul_lower_riscv_nsw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := mul_llvm_nsw_32
  rhs := mul_riscv_32

def llvm_mul_lower_riscv_nuw_flag_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs := mul_llvm_nuw_32
  rhs := mul_riscv_32


/-! ### i64 -/

@[simp_denote]
def mul_riscv_64 := [LV| {
    ^entry (%r1: i64, %r2: i64 ):
    %0 = "builtin.unrealized_conversion_cast"(%r1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%r2) : (i64) -> (!i64)
    %2 = mul  %1, %0 : !i64
    %3= "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

@[simp_denote]
def mul_llvm_noflag_64 := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def mul_llvm_nsw_64 := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def mul_llvm_nuw_64 := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nuw> : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def mul_llvm_flags_64 := [LV| {
    ^entry (%x: i64, %amount: i64):
    %1 = llvm.mul %x, %amount overflow<nsw,nuw> : i64
    llvm.return %1 : i64
  }]

def llvm_mul_lower_riscv_noflag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_noflag_64
  rhs := mul_riscv_64

def llvm_mul_lower_riscv_flags_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_flags_64
  rhs := mul_riscv_64

def llvm_mul_lower_riscv_nsw_flag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nsw_64
  rhs := mul_riscv_64

def llvm_mul_lower_riscv_nuw_flag_64 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := mul_llvm_nuw_64
  rhs := mul_riscv_64

def mul_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_flags_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nsw_flag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nuw_flag_8),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_flags_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nsw_flag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nuw_flag_16),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_flags_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nsw_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nuw_flag_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_noflag_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_flags_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nsw_flag_64),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_mul_lower_riscv_nuw_flag_64)
]
