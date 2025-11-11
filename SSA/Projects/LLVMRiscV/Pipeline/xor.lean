import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV
open LeanMLIR.SingleReturnCompat

/-!
  This file implements the lowering for the `llvm.xor` instruction for type i32, i64.
-/

/-! ### i32 -/

@[simp_denote]
def llvm_xor_32: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 32)) := [LV| {
  ^entry (%x: i32, %y: i32):
    %0 = llvm.xor    %x, %y : i32
    llvm.return %0 : i32
  }]

@[simp_denote]
def xor_riscv_32: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 32), .llvm (.bitvec 32)]⟩
  .pure (.llvm (.bitvec 32)) := [LV| {
  ^entry (%x: i32, %y: i32):
    %x1 = "builtin.unrealized_conversion_cast"(%x) : (i32) -> (!i64)
    %x2 = "builtin.unrealized_conversion_cast"(%y) : (i32) -> (!i64)
    %1 = xor %x1, %x2 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i32)
    llvm.return %2 : i32
  }]

def llvm_xor_lower_riscv_32: LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] :=
  {lhs := llvm_xor_32, rhs := xor_riscv_32}

/-! ### i64 -/

@[simp_denote]
def llvm_xor_64: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%x: i64, %y: i64):
    %0 = llvm.xor    %x, %y : i64
    llvm.return %0 : i64
  }]

@[simp_denote]
def xor_riscv_64: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%x: i64, %y: i64):
    %x1 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %x2 = "builtin.unrealized_conversion_cast"(%y) : (i64) -> (!i64)
    %1 = xor %x1, %x2 : !i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]

def llvm_xor_lower_riscv_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_xor_64, rhs := xor_riscv_64}

def xor_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_xor_lower_riscv_32),
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_xor_lower_riscv_64)
]
