
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_of_symmetric_selects_commuted_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 1),
  ¬x_3 = 1#1 → ¬x_2 = 1#1 → x_2 ^^^ x_3 = 1#1 → x_1 = x :=
sorry