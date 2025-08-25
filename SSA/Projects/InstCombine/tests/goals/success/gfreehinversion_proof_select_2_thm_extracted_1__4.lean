
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_2_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8) (x_2 x_3 : BitVec 1),
  x_3 = 1#1 → ¬x_2 = 1#1 → x ^^^ 123#8 ^^^ -1#8 = x ^^^ BitVec.ofInt 8 (-124) :=
sorry