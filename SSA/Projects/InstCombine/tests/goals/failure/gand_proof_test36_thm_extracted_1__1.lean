
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test36_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (x + 7#32 &&& 240#32).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (zeroExtend 64 x + 7#64 &&& 240#64)) PoisonOr.poison :=
sorry