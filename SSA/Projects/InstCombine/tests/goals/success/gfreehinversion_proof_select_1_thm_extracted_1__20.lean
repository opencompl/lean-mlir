
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_1_thm.extracted_1._20 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 x_4 : BitVec 8) (x_5 : BitVec 1),
  ¬x_5 = 1#1 → ¬x_2 = 1#1 → x ^^^ 123#8 ^^^ -1#8 = x ^^^ BitVec.ofInt 8 (-124) :=
sorry