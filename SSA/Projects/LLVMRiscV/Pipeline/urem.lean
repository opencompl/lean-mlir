import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

open LLVMRiscV

/-!
  This file implements the lowering for the `llvm.udiv` instruction for type i64.
-/

/-! ### i64 -/

@[simp_denote]
def llvm_urem_64 : Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%x: i64, %y: i64 ):
    %1 = llvm.urem    %x, %y : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def urem_riscv_64: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%reg1: i64, %reg2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = remu %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]

  def llvm_urem_lower_riscv_64: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_urem_64, rhs := urem_riscv_64}

def urem_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) := [
   mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND llvm_urem_lower_riscv_64)
]
