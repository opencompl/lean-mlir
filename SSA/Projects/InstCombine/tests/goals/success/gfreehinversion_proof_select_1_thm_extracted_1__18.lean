
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_1_thm.extracted_1._18 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 x_4 : BitVec 8) (x_5 : BitVec 1),
  x_5 = 1#1 → x_4 ^^^ (x_3 ^^^ 45#8) ^^^ -1#8 = x_3 ^^^ x_4 ^^^ BitVec.ofInt 8 (-46) :=
sorry