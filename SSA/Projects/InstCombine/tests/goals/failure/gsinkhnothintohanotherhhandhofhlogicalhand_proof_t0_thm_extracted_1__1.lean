
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 ^^^ 1#1 = 1#1 →
    x_1 = 1#1 →
      0#1 = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value x) PoisonOr.poison :=
sorry