
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem AndZextAnd_thm.extracted_1._1 : ∀ (x : BitVec 3),
  True ∧ (x &&& 2#3).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (zeroExtend 5 (x &&& 3#3) &&& 14#5)) PoisonOr.poison :=
sorry