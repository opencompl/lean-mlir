
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_fold_or_disjoint_cnt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& 3#8 != 0) = true ∨ x ||| 3#8 ≥ ↑8) →
    x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (2#8 <<< (x ||| 3#8))) PoisonOr.poison :=
sorry