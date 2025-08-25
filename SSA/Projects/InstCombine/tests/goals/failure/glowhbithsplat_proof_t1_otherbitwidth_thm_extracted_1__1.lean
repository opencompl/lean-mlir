
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_otherbitwidth_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(15#16 ≥ ↑16 ∨ 15#16 ≥ ↑16) →
    True ∧ (0#16).ssubOverflow (x &&& 1#16) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x <<< 15#16).sshiftRight' 15#16)) PoisonOr.poison :=
sorry