
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_shl_nuw_nsw2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨
        True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
          x_1 ≥ ↑8 ∨ True ∧ (x <<< x_1).sshiftRight' x_1 ≠ x ∨ x_1 ≥ ↑8 ∨ x <<< x_1 = 0) →
    x = 0 → False :=
sorry