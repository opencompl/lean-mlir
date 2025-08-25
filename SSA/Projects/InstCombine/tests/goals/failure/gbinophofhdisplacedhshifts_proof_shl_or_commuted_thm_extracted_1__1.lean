
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_commuted_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x + 1#8 ≥ ↑8 ∨ x ≥ ↑8) →
    x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (3#8 <<< (x + 1#8) ||| 16#8 <<< x)) PoisonOr.poison :=
sorry