
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._3 : ∀ (x : BitVec 41),
  ¬ofBool (x <ₛ 0#41) = 1#1 →
    40#41 ≥ ↑41 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 41)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 0#41) PoisonOr.poison :=
sorry