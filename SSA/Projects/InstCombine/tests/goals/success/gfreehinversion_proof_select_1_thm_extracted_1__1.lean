
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 → x_1 ^^^ (x ^^^ 45#8) ^^^ -1#8 = x ^^^ x_1 ^^^ BitVec.ofInt 8 (-46) :=
sorry