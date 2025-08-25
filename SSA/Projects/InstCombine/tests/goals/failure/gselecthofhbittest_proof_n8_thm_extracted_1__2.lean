
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 1#32) = 1#1 →
    ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
      2#32 ≥ ↑32 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 1#32) PoisonOr.poison :=
sorry