
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_cond_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 ^^^ 1#1 = 1#1 →
    x_1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value x) PoisonOr.poison :=
sorry