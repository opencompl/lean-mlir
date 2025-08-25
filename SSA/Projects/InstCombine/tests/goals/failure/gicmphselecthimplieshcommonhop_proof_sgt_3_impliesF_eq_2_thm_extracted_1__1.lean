
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_3_impliesF_eq_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (3#8 <ₛ x) = 1#1 →
    ofBool (x <ₛ 4#8) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (2#8 == x))) PoisonOr.poison :=
sorry