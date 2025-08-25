
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_ashr_not_commuted_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    x_1 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_2.sshiftRight' x_1 ^^^ -1#8 ||| x.sshiftRight' x_1)) PoisonOr.poison :=
sorry