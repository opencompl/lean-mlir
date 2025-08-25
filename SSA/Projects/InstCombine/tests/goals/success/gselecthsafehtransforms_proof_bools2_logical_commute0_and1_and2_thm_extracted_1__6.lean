
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bools2_logical_commute0_and1_and2_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 &&& x_1 = 1#1 → ¬x_2 = 1#1 → (x_2 ^^^ 1#1) &&& x = x :=
sorry