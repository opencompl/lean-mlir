
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p2_slt_65536_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 65536#32) = 1#1 →
    ¬ofBool (65535#32 <ₛ x) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 65535#32) PoisonOr.poison :=
sorry