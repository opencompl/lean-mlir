
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 16),
  4#16 ≥ ↑16 ∨ True ∧ (x >>> 4#16 &&& 1#16).saddOverflow (-1#16) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 32 (ofBool (x &&& 16#16 != 16#16)))) PoisonOr.poison :=
sorry