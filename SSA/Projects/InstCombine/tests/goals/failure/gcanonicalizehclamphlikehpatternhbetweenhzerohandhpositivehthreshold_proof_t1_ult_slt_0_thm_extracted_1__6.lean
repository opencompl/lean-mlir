
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_ult_slt_0_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ 65536#32) = 1#1 →
    ¬ofBool (65535#32 <ₛ x_1) = 1#1 →
      ofBool (x_1 <ₛ 0#32) = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value x_1) PoisonOr.poison :=
sorry