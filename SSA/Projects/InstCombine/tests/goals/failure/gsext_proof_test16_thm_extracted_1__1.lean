
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._1 : ∀ (x : BitVec 16),
  12#16 ≥ ↑16 ∨ 15#16 ≥ ↑16 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 32 (ofBool (x &&& 8#16 == 8#16)))) PoisonOr.poison :=
sorry