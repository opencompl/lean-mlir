
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_non_const_sides_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → x - zeroExtend 64 x_1 = x + -1#64 :=
sorry