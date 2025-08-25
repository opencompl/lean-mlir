
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test21_thm.extracted_1._1 : ∀ (x : BitVec 32),
  2#32 ≥ ↑32 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (zeroExtend 32 (ofBool (x &&& 4#32 != 0#32)))) PoisonOr.poison :=
sorry