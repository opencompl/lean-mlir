
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_logic_or_logic_and_2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬x_1 ||| x = 1#1 →
    ¬x_1 = 1#1 →
      x = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 0#1) PoisonOr.poison :=
sorry