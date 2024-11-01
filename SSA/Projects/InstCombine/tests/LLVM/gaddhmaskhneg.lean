
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gaddhmaskhneg_statements

def dec_mask_neg_i32_before := [llvm|
{
^0():
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def dec_mask_neg_i32_after := [llvm|
{
^0():
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %0, %0 : i32
  %2 = llvm.neg %0 : i32
  %3 = llvm.neg %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]

set_option diagnostics true
--set_option diagnostics.threshold 1
--set_option debug.skipKernelTC true in
theorem dec_mask_neg_i32_proof : dec_mask_neg_i32_before ⊑ dec_mask_neg_i32_after := by
  unfold dec_mask_neg_i32_before dec_mask_neg_i32_after
  simp_alive_meta
  simp (config := {failIfUnchanged := false }) only [
    Com.changeDialect_var, Expr.changeDialect]
    /- access the valuation -/
  intros Γv
  /- Simplify away the core framework -/
  simp (config := {failIfUnchanged := false, implicitDefEqProofs := false}) only [
    Com.denote, Expr.denote,
    DialectDenote.denote,
    InstCombine.Op.denote]


  simp (config := {failIfUnchanged := false, implicitDefEqProofs := false}) only [EffectKind.liftEffect_rfl, id_eq]
  simp (config := {failIfUnchanged := false, implicitDefEqProofs := false}) only [
    HVector.getN, HVector.get
  ]
