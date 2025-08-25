
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15_thm.extracted_1._1 : ∀ (x : BitVec 32),
  27#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 32 (ofBool (x &&& 16#32 != 0#32)))) PoisonOr.poison :=
sorry