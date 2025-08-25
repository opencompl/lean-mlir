
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_1_thm.extracted_1._11 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 x_3 : BitVec 8) (x_4 : BitVec 1),
  x_4 = 1#1 → x_3 ^^^ (x_2 ^^^ 45#8) ^^^ -1#8 = x_2 ^^^ x_3 ^^^ BitVec.ofInt 8 (-46) :=
sorry