
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_ashr_thm.extracted_1._3 : ∀ (x x_1 : BitVec 128) (x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    0#128 ≥ ↑128 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 128)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value x_1) PoisonOr.poison :=
sorry