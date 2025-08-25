
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_or_not_cond_reuse_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 →
    x ^^^ 1#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x ^^^ 1#1)) PoisonOr.poison :=
sorry