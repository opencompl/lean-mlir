
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 33),
  ¬4096#33 = 0 →
    12#33 ≥ ↑33 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 33)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x / 4096#33)) PoisonOr.poison :=
sorry