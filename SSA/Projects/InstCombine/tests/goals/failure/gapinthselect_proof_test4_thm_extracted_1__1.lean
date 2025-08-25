
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._1 : ∀ (x : BitVec 1023),
  ofBool (x <ₛ 0#1023) = 1#1 →
    1022#1023 ≥ ↑1023 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1023)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (-1#1023)) PoisonOr.poison :=
sorry