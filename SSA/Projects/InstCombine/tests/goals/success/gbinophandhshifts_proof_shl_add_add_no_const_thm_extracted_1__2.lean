
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_add_no_const_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨ x_2 ≥ ↑8) → ¬x_2 ≥ ↑8 → x_3 <<< x_2 + (x_1 <<< x_2 + x) = (x_1 + x_3) <<< x_2 + x :=
sorry