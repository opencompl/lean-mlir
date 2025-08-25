
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem C0zero_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 + 10#8 <ᵤ 0#8) = 1#1 →
    ofBool (x_1 <ₛ BitVec.ofInt 8 (-10)) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value x_1) PoisonOr.poison :=
sorry