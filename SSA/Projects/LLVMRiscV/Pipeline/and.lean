import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.LLVMRiscV.Pipeline.simpproc
import SSA.Projects.LLVMRiscV.Pipeline.simpriscv
import Lean

open LLVMRiscV
open RV64Semantics -- needed to use RISC-V semantics in simp tactic
open InstCombine(LLVM) -- analog to RISC-V

/- # AND -/
def and_llvm : Com  LLVMPlusRiscV [.llvm (.bitvec 64), .llvm (.bitvec 64)] .pure (.llvm (.bitvec 64))  := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %1 = llvm.and %lhs, %rhs : i64
      llvm.return %1 : i64
  }]

def and_riscv := [LV| {
    ^entry (%lhs: i64, %rhs: i64 ):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %rhsr = "builtin.unrealized_conversion_cast"(%rhs) : (i64) -> !i64
      %0 = and %lhsr, %rhsr : !i64
      %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
      llvm.return %1 : i64
  }]

def llvm_and_lower_riscv : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64) , Ty.llvm (.bitvec 64)] :=
  {lhs:= and_llvm , rhs:= and_riscv ,
   correct := by
    unfold and_llvm and_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [toOption_getSome]
    bv_decide
    }
