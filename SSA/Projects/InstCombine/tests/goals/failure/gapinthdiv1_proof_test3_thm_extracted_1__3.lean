
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 59),
  ¬x = 1#1 →
    ¬4096#59 = 0 →
      12#59 ≥ ↑59 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 59)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x_1 / 4096#59)) PoisonOr.poison :=
sorry