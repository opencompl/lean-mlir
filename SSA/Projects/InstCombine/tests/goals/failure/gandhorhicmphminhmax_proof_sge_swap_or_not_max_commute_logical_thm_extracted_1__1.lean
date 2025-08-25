
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_swap_or_not_max_commute_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 != 127#8) = 1#1 → ofBool (x ≤ₛ x_1) = 1#1 :=
sorry