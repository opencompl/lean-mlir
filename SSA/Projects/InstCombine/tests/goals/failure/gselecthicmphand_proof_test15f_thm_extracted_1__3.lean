
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15f_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 128#32 != 0#32) = 1#1 →
    1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 256#32) PoisonOr.poison :=
sorry