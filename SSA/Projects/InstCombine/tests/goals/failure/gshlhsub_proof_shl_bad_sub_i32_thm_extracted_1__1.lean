
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_bad_sub_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬32#32 - x ≥ ↑32 →
    True ∧ 1#32 <<< (32#32 - x) >>> (32#32 - x) ≠ 1#32 ∨ 32#32 - x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (1#32 <<< (32#32 - x))) PoisonOr.poison :=
sorry