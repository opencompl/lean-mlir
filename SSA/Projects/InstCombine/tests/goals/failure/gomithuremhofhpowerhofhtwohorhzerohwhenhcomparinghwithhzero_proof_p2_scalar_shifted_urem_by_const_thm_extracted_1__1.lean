
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p2_scalar_shifted_urem_by_const_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ 3#32 = 0) →
    True ∧ (x_1 &&& 1#32) <<< x >>> x ≠ x_1 &&& 1#32 ∨ x ≥ ↑32 ∨ 3#32 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool ((x_1 &&& 1#32) <<< x % 3#32 == 0#32))) PoisonOr.poison :=
sorry