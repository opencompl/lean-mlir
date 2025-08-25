import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.xor` instruction for type i64.
-/

/-! ### i64 -/

@[simp_denote]
def llvm_xor_64: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
    .pure (.llvm (.bitvec 64)) := [LV| {
    ^entry (%x: i64, %y: i64):
      %0 = llvm.xor  %x, %y : i64
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

def llvm_xor_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs := llvm_xor
  rhs := xor_riscv

def xor_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
  mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_xor_lower_riscv)
]
