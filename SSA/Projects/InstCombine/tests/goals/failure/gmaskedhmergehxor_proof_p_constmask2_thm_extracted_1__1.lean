
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_constmask2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 61440#32 &&& (x &&& BitVec.ofInt 32 (-65281)) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (x_1 &&& 61440#32 ^^^ x &&& BitVec.ofInt 32 (-65281))) PoisonOr.poison :=
sorry