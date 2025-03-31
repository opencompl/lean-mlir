/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.ForStd
import SSA.Core.ErasedContext
import SSA.Core.Tactic

open MLIR AST

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
        simp_peephole [] at Γv

        simp (config := {failIfUnchanged := false}) only [
            HVector.getN, HVector.get,
            beq_self_eq_true, Option.isSome_some, HVector.cons_get_zero
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
        simp_alive_ssa
      )
   )
