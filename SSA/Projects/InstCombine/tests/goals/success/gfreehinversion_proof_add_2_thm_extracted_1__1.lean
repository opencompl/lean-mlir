
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  x_1 = 1#1 → x_2 + (x ^^^ -1#8) ^^^ -1#8 = x - x_2 :=
sorry