import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement

open MLIR AST
open Std (BitVec)

/--
- We first simplify `ICom.refinement` to see the context `Γv`.
- We `simp_peephole Γv` to simplify context accesses by variables.
- We simplify the translation overhead.
- Then we introduce variables, `cases` on the variables to eliminate the `none` cases.
- We cannot leave it at this state, since then the variables will be inaccessible.
- So, we revert the variables for the user to re-introduce them as they see fit.
-/
macro "simp_alive_peephole" : tactic =>
  `(tactic|
      (
        dsimp only [ICom.Refinement]
        intros Γv
        simp_peephole at Γv
        /- note that we need the `HVector.toPair`, `HVector.toSingle` lemmas since it's used in `InstCombine.Op.denote`
          We need `HVector.toTuple` since it's used in `MLIR.AST.mkOpExpr`. -/
        try simp (config := {decide := false}) only [OpDenote.denote, InstCombine.Op.denote, HVector.toPair, pairMapM, BitVec.Refinement,
          bind, Option.bind, pure,
          DerivedContext.ofContext, DerivedContext.snoc, Ctxt.snoc,
          MOp.instantiateCom, InstCombine.MTy.instantiate, ConcreteOrMVar.instantiate,
          Vector.get, HVector.toSingle, HVector.toTuple, List.nthLe]
        try intros v0
        try intros v1
        try intros v2
        try intros v3
        try intros v4
        try intros v5
        try cases' v0 with x0 <;> simp
          <;> try cases' v1 with x1 <;> simp
          <;> try cases' v2 with x2 <;> simp
          <;> try cases' v3 with x3 <;> simp
          <;> try cases' v4 with x4 <;> simp
          <;> try cases' v5 with x5 <;> simp
        try revert v5
        try revert v4
        try revert v3
        try revert v2
        try revert v1
        try revert v0
      )
   )
