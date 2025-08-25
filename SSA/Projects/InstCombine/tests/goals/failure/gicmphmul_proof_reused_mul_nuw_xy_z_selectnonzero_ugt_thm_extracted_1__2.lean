
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reused_mul_nuw_xy_z_selectnonzero_ugt_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 != 0#8) = 1#1 →
    ¬ofBool (x_1 == 0#8) = 1#1 →
      True ∧ x.umulOverflow x_1 = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 1#1) PoisonOr.poison :=
sorry