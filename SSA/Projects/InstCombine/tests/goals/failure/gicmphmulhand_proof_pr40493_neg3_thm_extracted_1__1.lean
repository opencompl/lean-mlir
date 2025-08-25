
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr40493_neg3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  2#32 ≥ ↑32 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (x * 12#32 &&& 4#32)) PoisonOr.poison :=
sorry