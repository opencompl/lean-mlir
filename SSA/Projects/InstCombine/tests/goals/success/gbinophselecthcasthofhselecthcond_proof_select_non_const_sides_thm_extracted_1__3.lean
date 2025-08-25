
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_non_const_sides_thm.extracted_1._3 : ∀ (x x_1 : BitVec 64) (x_2 : BitVec 1),
  x_2 = 1#1 → x_1 - zeroExtend 64 x_2 = x_1 + -1#64 :=
sorry