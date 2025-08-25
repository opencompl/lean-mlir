
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_of_symmetric_selects_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 1),
  x_3 = 1#1 → ¬x_2 = 1#1 → ¬x_2 ^^^ x_3 = 1#1 → x = x_1 :=
sorry