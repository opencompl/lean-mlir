/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.TacticAuto
import Mathlib.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Tactic
import Batteries.Data.BitVec
import Mathlib.Data.BitVec.Lemmas

open MLIR AST
open Ctxt

/-- We eliminate our alive framework's metavarible machinery.
At the end of this pass, all `InstcombineTransformDialect.instantiate*` must be eliminated,
and all `Width.mvar` should be resolved into `Width.concrete`.  -/
macro "simp_alive_meta" : tactic =>
 `(tactic|
     (dsimp (config := {failIfUnchanged := false }) only [Functor.map]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.DerivedCtxt.snoc_ctxt_eq_ctxt_snoc]
      dsimp (config := {failIfUnchanged := false }) only [Var.succ_eq_toSnoc] -- TODO: added by Tobias ->  double-check.
      dsimp (config := {failIfUnchanged := false }) only [Var.zero_eq_last, List.map] -- @bollu is scared x(
      dsimp (config := {failIfUnchanged := false }) only [Width.mvar] -- TODO: write theorems in terms of Width.mvar?
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.map_snoc, Ctxt.map_nil]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.get?] -- TODO: added by Tobias ->  double-check.
      dsimp (config := {failIfUnchanged := false }) only [InstcombineTransformDialect.MOp.instantiateCom,
        ConcreteOrMVar.instantiate_mvar_zero']
      dsimp (config := {failIfUnchanged := false }) only [
        ConcreteOrMVar.instantiate_mvar_zero''] -- TODO: added by Tobias ->  double-check.
      dsimp (config := {failIfUnchanged := false, autoUnfold := true }) only [ConcreteOrMVar.instantiate_concrete_eq]
      dsimp (config := {failIfUnchanged := false, autoUnfold := true }) only [Ctxt.map, Ctxt.snoc]
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
            InstCombine.Op.denote, HVector.getN, HVector.get, List.get
          ]
        simp (config := {failIfUnchanged := false}) only [Int.reduceNegSucc,
            Int.reduceNeg, Nat.reduceAdd, Fin.cast_eq_self, List.get_cons_zero,
            Ctxt.get?, Var.zero_eq_last, Ctxt.Valuation.snoc_last
          ]
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
