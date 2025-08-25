
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_of_symmetric_selects_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x_1 = 1#1 → x_1 ^^^ x_2 = 1#1 → False :=
sorry