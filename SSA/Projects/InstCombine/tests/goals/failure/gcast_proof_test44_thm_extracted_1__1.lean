
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test44_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (zeroExtend 16 x ||| 1234#16).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (zeroExtend 64 (zeroExtend 16 x ||| 1234#16))) PoisonOr.poison :=
sorry