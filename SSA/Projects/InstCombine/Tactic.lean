/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.ForStd
import Mathlib.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Tactic
import Std.Data.BitVec
import Mathlib.Data.BitVec.Lemmas

open MLIR AST
open Ctxt

attribute [simp_llvm_case_bash]
  BitVec.Refinement.refl BitVec.Refinement.some_some BitVec.Refinement.none_left
  bind_assoc forall_const
  Option.bind_eq_bind Option.none_bind Option.bind_none Option.some_bind Option.pure_def
  BitVec.reduceOfInt Nat.cast_one
/- `reduceOfInt` and `Nat.cast_one` are somewhat questionable additions to this simp-set.
   They are not needed for the case-bashing to succeed, but they are simp-lemmas that were
   previously being applied in `AliveAutoGenerated`, where they closed a few trivial goals,
   so they've been preserved to not change this existing behaviour of `simp_alive_case_bash` -/

/--
`simp_alive_case_bash` transforms a goal of the form
  `∀ (x₁ : Option (BitVec _)) ... (xₙ : Option (BitVec _)), ...`
into a goal about just `BitVec`s, by doing a case distinction on each `Option`.

Then, we `simp`lify each goal, following the assumption that the `none` cases
should generally be trivial, hopefully leaving us with just a single goal:
the one where each option is `some`. -/
syntax "simp_alive_case_bash" : tactic
macro_rules
  | `(tactic| simp_alive_case_bash) => `(tactic|
    first
    | fail_if_success (intro (v : Option (_)))
      -- If there is no variable to introduce, `intro` fails, so the first branch succeeds,
      -- but does nothing. This is similar to `try`, except `first ...` does not swallow any errors
      -- that occur in the later tactics
    | intro (v : Option (_))    -- Introduce the variable,
      rcases v with _|x         -- Do the case distinction
      <;> simp (config:={failIfUnchanged := false}) only [simp_llvm_case_bash]
      --  ^^^^^^^^^^^^^^^^^^^^^^^^ Simplify, in the hopes that the `none` case is trivially closed
      <;> simp_alive_case_bash  -- Recurse, to case bash the next variable (if it exists)
      <;> (try revert x)        -- Finally, revert the variable we got in the `some` case, so that
                                --   we are left with a universally quantified goal of the form:
                                --   `∀ (x₁ : BitVec _) ... (xₙ : BitVec _), ...`
    )
/-- We eliminate our alive framework's metavarible machinery.
At the end of this pass, all `InstcombineTransformDialect.instantiate*` must be eliminated,
and all `Width.mvar` should be resolved into `Width.concrete`.  -/
macro "simp_alive_meta" : tactic =>
 `(tactic|
     (dsimp (config := {failIfUnchanged := false }) only [Com.Refinement]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.DerivedCtxt.snoc_ctxt_eq_ctxt_snoc]
      dsimp (config := {failIfUnchanged := false }) only [Var.succ_eq_toSnoc] -- TODO: added by Tobias ->  double-check.
      dsimp (config := {failIfUnchanged := false }) only [Var.zero_eq_last, List.map] -- @bollu is scared x(
      dsimp (config := {failIfUnchanged := false }) only [Width.mvar] -- TODO: write theorems in terms of Width.mvar?
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.map_snoc, Ctxt.map_nil]
      dsimp (config := {failIfUnchanged := false }) only [Ctxt.get?] -- TODO: added by Tobias ->  double-check.
      dsimp (config := {failIfUnchanged := false }) only [InstcombineTransformDialect.MOp.instantiateCom,
        InstcombineTransformDialect.instantiateMTy_eq]
      dsimp (config := {failIfUnchanged := false }) only [ConcreteOrMVar.instantiate_mvar_zero]
      dsimp (config := {failIfUnchanged := false, autoUnfold := true }) only [ConcreteOrMVar.instantiate_concrete_eq]
      dsimp (config := {failIfUnchanged := false, autoUnfold := true }) only [Ctxt.map]
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
            InstCombine.Op.denote, HVector.getN, HVector.get
          ]
      )
  )

/-- Unfold into the `undef' statements and eliminates as much as possible. -/
macro "simp_alive_undef" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm_option,
            BitVec.Refinement, bind_assoc,
          ]
      )
  )

/- Simplify away the `InstCombine` specific semantics. -/
macro "simp_alive_ops" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm, BitVec.bitvec_minus_one, pure_bind
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
        simp_alive_undef
        simp_alive_ops
        /- Attempt to case bash each `Option`, since the `none` cases are generally trivial -/
        simp_alive_case_bash
        try intros -- introduce the variables again (as otherwise the 'apply' in
                   -- AliveAutoGenerated.lean does not work)
      )
   )
