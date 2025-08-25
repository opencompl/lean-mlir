
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_31_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬31#64 ≥ ↑64 →
    31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 (x <<< 31#64))) PoisonOr.poison :=
sorry