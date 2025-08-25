
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_lshr_reverse_no_nsw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨
        x ≥ ↑32 ∨
          True ∧ x_2.usubOverflow (x_1 <<< x) = true ∨
            True ∧ (x_2 - x_1 <<< x) >>> x <<< x ≠ x_2 - x_1 <<< x ∨ x ≥ ↑32) →
    True ∧ x_2 >>> x <<< x ≠ x_2 ∨ x ≥ ↑32 ∨ True ∧ (x_2 >>> x).usubOverflow x_1 = true → False :=
sorry