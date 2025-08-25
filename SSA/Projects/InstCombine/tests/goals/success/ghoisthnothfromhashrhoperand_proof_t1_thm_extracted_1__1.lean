
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ^^^ -1#8) >>> x <<< x ≠ x_1 ^^^ -1#8 ∨ x ≥ ↑8) → x ≥ ↑8 → False :=
sorry