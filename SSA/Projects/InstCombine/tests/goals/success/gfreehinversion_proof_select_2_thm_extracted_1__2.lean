
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_2_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 x_2 : BitVec 1),
  x_2 = 1#1 → ¬x_1 = 1#1 → x ^^^ 123#8 ^^^ -1#8 = x ^^^ BitVec.ofInt 8 (-124) :=
sorry