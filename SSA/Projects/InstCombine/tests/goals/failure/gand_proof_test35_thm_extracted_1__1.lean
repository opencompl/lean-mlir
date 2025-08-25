
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test35_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (0#32 - x &&& 240#32).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (0#64 - zeroExtend 64 x &&& 240#64)) PoisonOr.poison :=
sorry