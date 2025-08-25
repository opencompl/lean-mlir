
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test70_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 <ₛ 0#8) = 1#1 →
    6#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x ||| 2#8)) PoisonOr.poison :=
sorry