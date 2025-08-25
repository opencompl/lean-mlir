
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_lshr_var_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    x ≥ ↑64 ∨ 2#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 (x_1 >>> x <<< 2#64))) PoisonOr.poison :=
sorry