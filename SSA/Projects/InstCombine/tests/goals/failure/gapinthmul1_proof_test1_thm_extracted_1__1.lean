
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 17),
  10#17 ≥ ↑17 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 17)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (x * 1024#17)) PoisonOr.poison :=
sorry