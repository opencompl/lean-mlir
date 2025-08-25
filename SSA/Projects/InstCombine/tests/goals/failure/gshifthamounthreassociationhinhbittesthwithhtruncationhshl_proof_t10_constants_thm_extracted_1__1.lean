
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t10_constants_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 14#64 ≥ ↑64) →
    26#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (x_1 >>> 12#32 &&& truncate 32 (x <<< 14#64) != 0#32))) PoisonOr.poison :=
sorry