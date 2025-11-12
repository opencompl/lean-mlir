import SSA.Projects.RISCV64.PrettyEDSL
import LeanMLIR.Framework
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

/-!
  Bug reported in https://github.com/llvm/llvm-project/issues/59876
-/

namespace BitVec
open LLVMRiscV

@[simp_denote]
def original := [LV| {
  ^entry (%x : i1):
  %1 = llvm.mlir.constant (1) : i1
  %0 = llvm.mul %x, %1 : i1
  llvm.return %0 : i1
}]

@[simp_denote]
def optimized_incorrect := [LV| {
  ^entry (%x : i1):
  %0 = llvm.mlir.constant (0) : i1
  llvm.return %0 : i1
  }]

@[simp_denote]
def optimized_correct := [LV| {
  ^entry (%x : i1):
  llvm.return %x : i1
  }]

def bug : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1)] where
  lhs:= original
  rhs:= optimized_incorrect
  correct := by
    simp_lowering
    <;> sorry

def fix : LLVMPeepholeRewriteRefine 1 [Ty.llvm (.bitvec 1)] where
  lhs:= original
  rhs:= optimized_correct
  correct := by
    simp_lowering
    bv_decide
