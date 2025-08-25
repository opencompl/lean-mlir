
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_2_thm.extracted_1._11 : ∀ (x x_1 : BitVec 8) (x_2 x_3 : BitVec 1),
  x_3 = 1#1 → ¬x_2 = 1#1 → x_1 ^^^ 123#8 ^^^ -1#8 = x_1 ^^^ BitVec.ofInt 8 (-124) :=
sorry