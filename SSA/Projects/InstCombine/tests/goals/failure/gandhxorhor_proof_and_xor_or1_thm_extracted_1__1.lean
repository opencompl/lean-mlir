
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_xor_or1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(x_2 = 0 ∨ x_1 = 0 ∨ x = 0 ∨ x_1 = 0) →
    x = 0 ∨ x_1 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (42#64 / x_2 &&& 42#64 / x_1 ^^^ 42#64 / x ||| 42#64 / x_1)) PoisonOr.poison :=
sorry