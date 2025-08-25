
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 333),
  ¬70368744177664#333 = 0 →
    46#333 ≥ ↑333 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 333)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x / 70368744177664#333)) PoisonOr.poison :=
sorry