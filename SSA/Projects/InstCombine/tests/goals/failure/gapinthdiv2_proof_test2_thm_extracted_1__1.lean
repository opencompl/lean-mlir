
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 499),
  ¬(197#499 ≥ ↑499 ∨ 4096#499 <<< 197#499 = 0) →
    209#499 ≥ ↑499 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 499)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x / 4096#499 <<< 197#499)) PoisonOr.poison :=
sorry