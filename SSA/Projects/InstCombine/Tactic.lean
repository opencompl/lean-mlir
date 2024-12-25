/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.ForStd
import Mathlib.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Tactic

open MLIR AST

/-- We eliminate our alive framework's metavarible machinery.
At the end of this pass, all `InstcombineTransformDialect.instantiate*` must be eliminated,
and all `Width.mvar` should be resolved into `Width.concrete`.  -/
macro "simp_alive_meta" : tactic =>
 `(tactic|
     (
      simp (config := {failIfUnchanged := false }) only [Com.changeDialect_ret,
        Com.changeDialect_var, Expr.changeDialect]
      simp (config := {failIfUnchanged := false }) only [(HVector.changeDialect_nil)]
      dsimp (config := {failIfUnchanged := false }) only [HVector.map']
      dsimp (config := {failIfUnchanged := false }) only [Functor.map]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.Var.succ_eq_toSnoc]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.Var.zero_eq_last]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.Var.toMap_last]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.DerivedCtxt.snoc_ctxt_eq_ctxt_snoc]
      dsimp (config := {failIfUnchanged := false }) only [List.map]
      dsimp (config := {failIfUnchanged := false }) only [Width.mvar]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.map_snoc, Ctxt.map_nil]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.get?]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.map, Ctxt.snoc]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.Var.toSnoc_toMap]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.Var.toMap_last]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.map_cons]
      dsimp (config := {failIfUnchanged := false }) only
        [InstcombineTransformDialect.MOp.instantiateCom]
      dsimp (config := {failIfUnchanged := false }) only
        [InstcombineTransformDialect.instantiateMTy]
      dsimp (config := {failIfUnchanged := false }) only [Fin.zero_eta, List.map_cons]
      dsimp (config := {failIfUnchanged := false }) only
        [InstcombineTransformDialect.instantiateMOp]
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_mvar_zero]
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_mvar_zero']
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_mvar_zero'']
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate]
      dsimp (config := {failIfUnchanged := false }) only
        [InstcombineTransformDialect.instantiateMTy]
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_mvar_zero'']
      -- How can I avoid this `simp! only` and instead use a plain `simp only`?
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.ofNat_eq_concrete]
      simp! (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_ofNat_eq]
   )
 )

/-- Eliminate the SSA structure of the program
- We first simplify `Com.refinement` to see the context `Γv`.
- We `simp_peephole Γv` to simplify context accesses by variables.
- We simplify the translation overhead.
-/
macro "simp_alive_ssa" : tactic =>
  `(tactic|
      (
        /- access the valuation -/
        intros Γv

        /- Simplify away the core framework -/
        simp_peephole [InstCombine.Op.denote] at Γv

        simp (config := {failIfUnchanged := false}) only [
            InstCombine.Op.denote, HVector.getN, HVector.get,
            beq_self_eq_true, Option.isSome_some, HVector.cons_nil_get
          ]

        -- Fold integers into their canonical form.
        simp (config := {failIfUnchanged := false }) only [Nat.cast_ofNat,
          Nat.cast_one, Int.reduceNegSucc, Int.reduceNeg]
      )
  )

/--
`simp_alive_peephole` extends `simp_peephole` to simplify goals about refinement of `LLVM`
programs into statements about just bitvectors.

That is, the tactic expects a goal of the form: `Com.Refinement com₁ com₂`
That is, goals of the form `Com.refine, com₁.denote Γv ⊑ com₂.denote Γv `,
where `com₁` and `com₂` are programs in the `LLVM` dialect. -/
macro "simp_alive_peephole" : tactic =>
  `(tactic|
      (
        simp_alive_meta
        simp_alive_ssa
      )
   )
