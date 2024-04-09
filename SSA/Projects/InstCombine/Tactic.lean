import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.ForStd
import Mathlib.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Tactic
import Std.Data.BitVec
import Mathlib.Data.BitVec.Lemmas

open MLIR AST
open Std (BitVec)
open Ctxt

-- TODO: Do we call this dialect the "Alive" dialect (as hinted by the `simp_alive_peephole` name),
--       or the "InstCombine" dialect (as hinted by the `InstCombine` namespace that everything
--       lives in), or the "LLVM" dialect (as we do in the paper, and the simp-sets,
--       and the `LLVM` namespace)?

open MLIR AST in
/--
`simp_alive_peephole` extends `simp_peephole` to simplify goals about refinement of `LLVM`
programs into statements about just bitvectors.

To wit, the tactic expects a goal of the form: `Com.Refinement com₁ com₂`
That is, goals of of the form `Com.refine, com₁.denote Γv ⊑ com₂.denote Γv `,
where `com₁` and `com₂` are programs in the `LLVM` dialect. -/
macro "simp_alive_peephole" : tactic =>
  `(tactic|
      (
        /- Unfold the meaning of refinement, to access the valuation -/
        dsimp only [Com.Refinement]
        intros Γv

        /- Simplify away the core framework -/
        simp_peephole [InstCombine.Op.denote] at Γv

        /- Simplify away the `InstCombine` specific semantics. -/
        simp (config := {failIfUnchanged := false}) only [
            BitVec.Refinement, bind, Option.bind, pure,
            simp_llvm,
            BitVec.bitvec_minus_one
          ]

        /-  At this point, we have should a goal of the form:
              `∀ (x₁ : Option (BitVec _)) ... (xₙ : Option (BitVec _)), ...`
            For some unknown number of variables `n` (but assumed to be `n ≤ 5`,
            as per the hack in `simp_peephole`).

            However, the `none` (i.e., poison) cases are generally trivial.
            Thus we attempt to introduce some variables (using `try` because the intro might fail
            if we have less universal quantifiers than `intro`s), case split on them, and simp
            through the monadic bind on `Option` (in the generally true assumption that the `none`
            case becomes trivial and is closed by `simp`). -/
        try intros v0
        try intros v1
        try intros v2
        try intros v3
        try intros v4
        try intros v5
        simp (config := {failIfUnchanged := false}) only [Option.bind, bind, Monad.toBind, Var.casesOn, cast, pairBind, Option.bind_eq_bind]
        try cases' v0 with x0 <;> simp[Option.bind, bind, Monad.toBind]
          <;> try cases' v1 with x1 <;> simp[Option.bind, bind, Monad.toBind]
          <;> try cases' v2 with x2 <;> simp[Option.bind, bind, Monad.toBind]
          <;> try cases' v3 with x3 <;> simp[Option.bind, bind, Monad.toBind]
          <;> try cases' v4 with x4 <;> simp[Option.bind, bind, Monad.toBind]
          <;> try cases' v5 with x5 <;> simp[Option.bind, bind, Monad.toBind]
          <;> dsimp[Option.bind, bind, Monad.toBind]

        /-
        CAVEAT: The following `revert`s currently have no effect,
        the variables `v$i` have been cases on,
        and the newly introduced variables (in the `some` cases) are called `x$i` instead,
        I've documented the intended behaviour below.
        TODO: fix or remove this

        Finally, revert the variables introduced in the `some` cases, so that we are left with a
        universally quantified goal of the form:
          `∀ (x₁ : BitVec _) ... (xₙ : BitVec _), ...` -/
        try revert v5
        try revert v4
        try revert v3
        try revert v2
        try revert v1
        try revert v0
      )
   )
