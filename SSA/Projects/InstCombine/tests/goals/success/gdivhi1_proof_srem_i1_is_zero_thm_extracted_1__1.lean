
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem srem_i1_is_zero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬(x == 0 || 1 != 1 && x_1 == intMin 1 && x == -1) = true → x_1.srem x = 0#1 :=
sorry