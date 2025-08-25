
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(7#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    True ∧ (0#8).ssubOverflow (x &&& 1#8) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x <<< 7#8).sshiftRight' 7#8)) PoisonOr.poison :=
sorry