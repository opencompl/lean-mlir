
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_xor_common_op_commute2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 = 0 ∨ x = 0 ∨ x = 0) →
    x = 0 ∨ x_1 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((43#32 / x_1 ^^^ 42#32 / x) &&& 42#32 / x)) PoisonOr.poison :=
sorry