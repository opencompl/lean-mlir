
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_2_thm.extracted_1._6 : ∀ (x : BitVec 8) (x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 → x ^^^ 45#8 ^^^ -1#8 = x ^^^ BitVec.ofInt 8 (-46) :=
sorry