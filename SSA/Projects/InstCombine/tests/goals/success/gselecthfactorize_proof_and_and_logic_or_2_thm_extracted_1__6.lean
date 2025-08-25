
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_and_logic_or_2_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 &&& x_1 = 1#1 → ¬x_1 = 1#1 → x &&& x_2 = x_2 &&& x :=
sorry