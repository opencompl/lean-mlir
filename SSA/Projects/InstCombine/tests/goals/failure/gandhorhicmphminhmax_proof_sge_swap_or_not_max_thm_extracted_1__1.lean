
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_swap_or_not_max_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ≤ₛ x) ||| ofBool (x != 127#8) = 1#1 :=
sorry