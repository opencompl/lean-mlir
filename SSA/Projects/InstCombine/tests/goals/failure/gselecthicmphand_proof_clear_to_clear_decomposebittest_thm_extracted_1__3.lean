
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem clear_to_clear_decomposebittest_thm.extracted_1._3 : ∀ (x : BitVec 8),
  ¬ofBool (-1#8 <ₛ x) = 1#1 →
    True ∧ (x &&& BitVec.ofInt 8 (-128) &&& 3#8 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (BitVec.ofInt 8 (-125))) PoisonOr.poison :=
sorry