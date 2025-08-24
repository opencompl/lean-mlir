import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV

/-! # REM -/

/-- This file contains the lowerings for the llvm rem instruction.
We take the diffrent possible flags into account. -/
@[simp_denote]
def rem_llvm := [LV| {
    ^entry (%x: i64, %y: i64):
    %1 = llvm.srem %x, %y : i64 -- in LLVM the first operand specifies the dividend, this means x % y
    llvm.return %1 : i64
  }]

@[simp_denote]
def rem_riscv := [LV| {
    ^entry (%reg1: i64, %reg2: i64 ):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i64) -> (!i64)
    %2 = rem  %0, %1 : !i64 -- in riscv the 2nd operand specifies the dividend
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

def llvm_rem_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := rem_llvm
  rhs := rem_riscv

def rem_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
   List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
  [llvm_rem_lower_riscv]

 /- i32 -/

@[simp_denote]
def rem_llvm_32 := [LV| {
    ^entry (%x: i32, %y: i32):
    %1 = llvm.srem %x, %y : i32 -- in LLVM the first operand specifies the dividend, this means x % y
    llvm.return %1 : i32
  }]
@[simp_denote]
def rem_riscv_32 := [LV| {
    ^entry (%reg1: i32, %reg2: i32):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i32) -> (!i64)
    %2 = rem  %0, %1 : !i64 -- in riscv the 2nd operand specifies the dividend
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i32)
    llvm.return %3 : i32
  }]

-- def llvm_rem_lower_riscv_32 : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
--   lhs := rem_llvm_32
--   rhs := rem_riscv_32

-- def rem_match_32 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
--    List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
--   [llvm_rem_lower_riscv_32]

 /- i16 -/
@[simp_denote]
def rem_llvm_16 := [LV| {
    ^entry (%x: i16, %y: i16):
    %1 = llvm.srem %x, %y : i16 -- in LLVM the first operand specifies the dividend, this means x % y
    llvm.return %1 : i16
  }]
@[simp_denote]
def rem_riscv_16 := [LV| {
    ^entry (%reg1: i16, %reg2: i16):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i16) -> (!i64)
    %2 = rem  %0, %1 : !i64 -- in riscv the 2nd operand specifies the dividend
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i16)
    llvm.return %3 : i16
  }]

-- def llvm_rem_lower_riscv_16 : LLVMPeepholeRewriteRefine 16 [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16)] where
--   lhs := rem_llvm_16
--   rhs := rem_riscv_16

-- def rem_match_16 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
--    List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
--   [llvm_rem_lower_riscv_16]

  /- i8 -/

@[simp_denote]
def rem_llvm_8 := [LV| {
    ^entry (%x: i8, %y: i8):
    %1 = llvm.srem %x, %y : i8 -- in LLVM the first operand specifies the dividend, this means x % y
    llvm.return %1 : i8
  }]
@[simp_denote]
def rem_riscv_8 := [LV| {
    ^entry (%reg1: i8, %reg2: i8):
    %0 = "builtin.unrealized_conversion_cast" (%reg1) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%reg2) : (i8) -> (!i64)
    %2 = rem  %0, %1 : !i64 -- in riscv the 2nd operand specifies the dividend
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!i64) -> (i8)
    llvm.return %3 : i8
  }]

-- def llvm_rem_lower_riscv_8 : LLVMPeepholeRewriteRefine 8 [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8)] where
--   lhs := rem_llvm_8
--   rhs := rem_riscv_8

-- def rem_match_8 : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
--    List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x))
--   [llvm_rem_lower_riscv_8]
