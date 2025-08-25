
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_7_i8_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬7#64 ≥ ↑64 →
    7#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (x <<< 7#64))) PoisonOr.poison :=
sorry