
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_15_i16_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬15#32 ≥ ↑32 →
    15#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 (x <<< 15#32))) PoisonOr.poison :=
sorry