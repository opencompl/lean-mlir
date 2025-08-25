
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test8_thm.extracted_1._1 : ∀ (x : BitVec 27),
  3#27 ≥ ↑27 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 27)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (9#27 * x - x)) PoisonOr.poison :=
sorry