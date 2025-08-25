
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_to_set_decomposebittest_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ₛ 0#8) = 1#1 →
    True ∧ (x &&& BitVec.ofInt 8 (-128) &&& 3#8 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (BitVec.ofInt 8 (-125))) PoisonOr.poison :=
sorry