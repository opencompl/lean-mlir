
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_non_const_sides_thm.extracted_1._4 : ∀ (x x_1 : BitVec 64) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → x - zeroExtend 64 x_2 = x :=
sorry