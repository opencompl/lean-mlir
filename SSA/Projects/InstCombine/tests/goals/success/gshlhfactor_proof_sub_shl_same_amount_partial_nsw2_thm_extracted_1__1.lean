
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_shl_same_amount_partial_nsw2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 6),
  ¬(x_1 ≥ ↑6 ∨
        True ∧ (x <<< x_1).sshiftRight' x_1 ≠ x ∨ x_1 ≥ ↑6 ∨ True ∧ (x_2 <<< x_1).ssubOverflow (x <<< x_1) = true) →
    x_1 ≥ ↑6 → False :=
sorry