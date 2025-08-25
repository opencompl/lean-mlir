
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem flip_add_of_shift_neg_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ ((0#8 - x_2) <<< x_1).sshiftRight' x_1 ≠ 0#8 - x_2 ∨
        True ∧ (0#8 - x_2) <<< x_1 >>> x_1 ≠ 0#8 - x_2 ∨ x_1 ≥ ↑8) →
    ¬x_1 ≥ ↑8 → (0#8 - x_2) <<< x_1 + x = x - x_2 <<< x_1 :=
sorry