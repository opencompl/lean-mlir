import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

import Lean
open LLVMRiscV

/-!
## Functionality
This file contains rewrites for the Peephole Rewriter to eliminate unrealized conversion casts.
The rewrites below are registered fold-away pairs of unrealized conversion casts.

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
