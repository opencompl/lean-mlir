
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p1_ugt_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (65534#32 <ᵤ x) = 1#1 →
    ¬ofBool (x <ᵤ 65535#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 65535#32) PoisonOr.poison :=
sorry