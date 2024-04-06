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

open MLIR AST in
/--
- We first simplify `Com.refinement` to see the context `Γv`.
- We `simp_peephole Γv` to simplify context accesses by variables.
- We simplify the translation overhead.
- Then we introduce variables, `cases` on the variables to eliminate the `none` cases.
- We cannot leave it at this state, since then the variables will be inaccessible.
- So, we revert the variables for the user to re-introduce them as they see fit.
-/
macro "simp_alive_peephole" : tactic =>
  `(tactic|
      (
        dsimp only [Com.Refinement]
        intros Γv
        simp_peephole at Γv
        /- note that we need the `HVector.toPair`, `HVector.toSingle`, `HVector.toTriple` lemmas since it's used in `InstCombine.Op.denote`
          We need `HVector.toTuple` since it's used in `MLIR.AST.mkOpExpr`. -/
        simp (config := {failIfUnchanged := false, unfoldPartialApp := true, zetaDelta := true}) only [
          InstCombine.Op.denote, HVector.toPair,
          BitVec.Refinement, bind, Option.bind, pure,
          HVector.toSingle,
          simp_llvm,
          HVector.toTuple, List.nthLe, BitVec.bitvec_minus_one
          ]
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
        try revert v5
        try revert v4
        try revert v3
        try revert v2
        try revert v1
        try revert v0
      )
   )
