
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_1_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  x_3 = 1#1 → x_2 ^^^ (x_1 ^^^ 45#8) ^^^ -1#8 = x_1 ^^^ x_2 ^^^ BitVec.ofInt 8 (-46) :=
sorry