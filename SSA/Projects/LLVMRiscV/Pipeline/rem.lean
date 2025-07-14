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
