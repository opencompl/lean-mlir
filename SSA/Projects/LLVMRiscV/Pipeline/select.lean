import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite
open LLVMRiscV
set_option Elab.async true

/-!
  This file contains the instruction lowering for the `llvm.select` instruction for types i8, i16, i32, i64.

  LLVM version 11.0 lowers `select` to a conditional branch regardless of the
  optimization level used. However, our current setup does not support branches.

  To handle this, we manually encode the semantics of the `select` instruction
  using bitwise operations. While this results in a longer RISC-V instruction
  sequence compared to LLVM's native lowering, it allows us to support lowering
  the instruction within our framework.
  -/

/-! ### i8  -/

@[simp_denote]
def select_riscv_8 := [LV| {
  ^entry (%cond : i1, %arg0: i8, %arg1: i8):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i8) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i8) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64 --propagating the condition bit to all bits within the 64 bit vector
    %5 = and %0, %4 : !i64 -- mask the value_true with the condition
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64 -- mask the value_false with the condition
    %9 = or %5, %8 : !i64 -- return either value_true or value_false
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i8)
    llvm.return %10 : i8
  }]

@[simp_denote]
def select_llvm_8 := [LV| {
  ^entry (%cond : i1, %arg0: i8, %arg1: i8):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
    llvm.return %0 : i8
  }]

def select_riscv_select_llvm_8 : LLVMPeepholeRewriteRefine 8
  [Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_8
  rhs := select_riscv_8


/-! ### i16  -/

@[simp_denote]
def select_riscv_16 := [LV| {
  ^entry (%cond : i1, %arg0: i16, %arg1: i16):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i16) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i16) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64 --propagating the condition bit to all bits within the 64 bit vector
    %5 = and %0, %4 : !i64 -- mask the value_true with the condition
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64 -- mask the value_false with the condition
    %9 = or %5, %8 : !i64 -- return either value_true or value_false
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i16)
    llvm.return %10 : i16
  }]

@[simp_denote]
def select_llvm_16 := [LV| {
  ^entry (%cond : i1, %arg0: i16, %arg1: i16):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
    llvm.return %0 : i16
  }]

def select_riscv_select_llvm_16 : LLVMPeepholeRewriteRefine 16
  [Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 16), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_16
  rhs := select_riscv_16


/-! ### i32  -/

@[simp_denote]
def select_riscv_32 := [LV| {
  ^entry (%cond : i1, %arg0: i32, %arg1: i32):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i32) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i32) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64 --propagating the condition bit to all bits within the 64 bit vector
    %5 = and %0, %4 : !i64 -- mask the value_true with the condition
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64 -- mask the value_false with the condition
    %9 = or %5, %8 : !i64 -- return either value_true or value_false
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i32)
    llvm.return %10 : i32
  }]

@[simp_denote]
def select_llvm_32 := [LV| {
  ^entry (%cond : i1, %arg0: i32, %arg1: i32):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    llvm.return %0 : i32
  }]

def select_riscv_select_llvm_32 : LLVMPeepholeRewriteRefine 32
  [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_32
  rhs := select_riscv_32


/-! ### i64 -/

@[simp_denote]
def select_riscv_64 := [LV| {
  ^entry (%cond : i1, %arg0: i64, %arg1: i64):
    %0 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast" (%arg1) : (i64) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast" (%cond) : (i1) -> (!i64)
    %3 = slli %2, 63 : !i64
    %4 = srai %3, 63 : !i64
    %5 = and %0, %4 : !i64
    %6 = li (18446744073709551615) : !i64
    %7 = xor %6, %4: !i64
    %8 = and %7, %1 : !i64
    %9 = or %5, %8 : !i64
    %10 = "builtin.unrealized_conversion_cast" (%9) : (!i64) -> (i64)
    llvm.return %10 : i64
  }]

@[simp_denote]
def select_llvm_64 := [LV| {
  ^entry (%cond : i1, %arg0: i64, %arg1: i64):
    %0 = "llvm.select"(%cond, %arg0, %arg1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def select_riscv_select_llvm_64 : LLVMPeepholeRewriteRefine 64
  [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 1)] where
  lhs := select_llvm_64
  rhs := select_riscv_64

def select_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  [⟨[Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64),Ty.llvm (.bitvec 1)],
   Ty.llvm (.bitvec 64),(LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND select_riscv_select_llvm_64)⟩,
  ⟨[Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32),Ty.llvm (.bitvec 1)],
   Ty.llvm (.bitvec 32),(LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND select_riscv_select_llvm_32)⟩,
   ⟨[Ty.llvm (.bitvec 8), Ty.llvm (.bitvec 8),Ty.llvm (.bitvec 1)],
   Ty.llvm (.bitvec 8),(LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND select_riscv_select_llvm_8)⟩]
