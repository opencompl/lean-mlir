
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_bad_sub_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬67#64 - x ≥ ↑64 →
    True ∧ 1#64 <<< (67#64 - x) >>> (67#64 - x) ≠ 1#64 ∨ 67#64 - x ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (1#64 <<< (67#64 - x))) PoisonOr.poison :=
sorry