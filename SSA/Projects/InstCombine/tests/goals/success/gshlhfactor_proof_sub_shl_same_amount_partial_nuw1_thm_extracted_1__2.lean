
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_shl_same_amount_partial_nuw1_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 6),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑6 ∨ True ∧ x <<< x_1 >>> x_1 ≠ x ∨ x_1 ≥ ↑6) →
    ¬x_1 ≥ ↑6 → x_2 <<< x_1 - x <<< x_1 = (x_2 - x) <<< x_1 :=
sorry