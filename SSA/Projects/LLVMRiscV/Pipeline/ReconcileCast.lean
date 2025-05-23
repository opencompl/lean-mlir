import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

import Lean
open LLVMRiscV

/-!
## Functionality
This file contains rewrites for the Peephole Rewriter to eliminate unrealized conversion cast.
The rewrites bellow are registered and similar to dead code elimination/ constant folding
unrealized conversion cast get eliminated.

An `unrealized conversion cast` in MLIR is an operation inserted during the lowering
from one dialect to another dialect to temporary guarantee compatible between type
systems. It is stating that an element should be casted to type B from type A.
-/


def cast_eliminiation_riscv : PeepholeRewrite LLVMPlusRiscV [Ty.riscv (.bv)] (Ty.riscv (.bv)) where
  lhs := [LV| {
      ^entry (%lhs: !i64):
      %addl = "builtin.unrealized_conversion_cast" (%lhs) : (!i64) -> (i64)
      %lhsr = "builtin.unrealized_conversion_cast"(%addl) : (i64) -> (!i64)
      ret %lhsr : !i64
    }]
  rhs := [LV| {
      ^entry (%lhs: !i64):
      ret %lhs : !i64
    }]
  correct := by
    simp_peephole
    intro e
    simp_riscv
    simp

def double_cast_elimination_LLVM_to_RISCV : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs:= [LV| {
      ^entry (%lhs: i64): -- this is a refinement
      %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
      %lhsr1 = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
      %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
      llvm.return %addl : i64
    }]
  rhs:= [LV| {
      ^entry (%lhs: i64):
      %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i64) -> (!i64)
      %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
      llvm.return %addl : i64
    }]
  correct := by
      simp_peephole
      intro e
      simp_riscv
      simp
  
