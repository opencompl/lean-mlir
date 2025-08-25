
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_selectp2_x_non_const_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x_1 ≥ ↑8 → 1#8 <<< x_1 * x = x <<< x_1 :=
sorry