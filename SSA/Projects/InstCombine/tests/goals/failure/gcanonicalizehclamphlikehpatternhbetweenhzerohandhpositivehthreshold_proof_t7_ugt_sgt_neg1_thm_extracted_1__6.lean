
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_ugt_sgt_neg1_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (65535#32 <ᵤ x_1) = 1#1 →
    ¬ofBool (-1#32 <ₛ x_1) = 1#1 →
      ofBool (65535#32 <ₛ x_1) = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value x) PoisonOr.poison :=
sorry