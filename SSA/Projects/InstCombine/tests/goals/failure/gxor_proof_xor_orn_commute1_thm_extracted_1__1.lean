
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_orn_commute1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 = 0 ∨ x_1 = 0) →
    x_1 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (42#8 / x_1 ^^^ (42#8 / x_1 ^^^ -1#8 ||| x))) PoisonOr.poison :=
sorry