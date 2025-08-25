
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_from_variable_of_sub_from_constant_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  x_1 - (42#8 - x) = x + BitVec.ofInt 8 (-42) + x_1 :=
sorry