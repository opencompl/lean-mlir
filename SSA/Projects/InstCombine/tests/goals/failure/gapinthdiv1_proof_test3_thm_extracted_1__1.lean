
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 59),
  x = 1#1 →
    ¬1024#59 = 0 →
      10#59 ≥ ↑59 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 59)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x_1 / 1024#59)) PoisonOr.poison :=
sorry