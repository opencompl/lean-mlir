import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV

import Lean
open LLVMRiscV

/-!
  This file contains rewrites for the Peephole Rewriter to eliminate unrealized conversion casts.
  The rewrites below are registered to fold-away pairs of unrealized conversion casts.

  An `unrealized conversion cast` in MLIR is an operation inserted during the lowering
  from one dialect to another dialect to temporarily guarantee compatibility between types.
  It is stating that an element should be casted to type B from type A.
-/

@[simp_denote]
def cast_eliminiation_riscv : PeepholeRewrite LLVMPlusRiscV [Ty.riscv (.bv)] (Ty.riscv (.bv)) where
  lhs := [LV| {
    ^entry (%arg: !i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg) : (!i64) -> (i64)
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!i64)
    ret %1 : !i64
  }]
  rhs := [LV| {
    ^entry (%arg: !i64):
    ret %arg : !i64
  }]
  correct := by
    simp_peephole
    intro e
    simp_riscv
    simp


def cast_eq_cast_cast_eliminiation_riscv : PeepholeRewrite LLVMPlusRiscV [Ty.llvm (.bitvec 64)] (Ty.llvm (.bitvec 64)) where
  lhs := [LV| {
    ^entry (%lhs: i64):
    %0 = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
    %1 = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
    %2= "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i64)
    llvm.return %2 : i64
  }]
  rhs := [LV| {
    ^entry (%lhs: i64):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
    %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
    llvm.return %addl : i64
  }]
  correct := by
   simp_peephole
   intro e
   simp
