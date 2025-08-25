
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_swap_or_max_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 ≤ₛ x) = 1#1 → ofBool (x == 127#8) = ofBool (x_1 ≤ₛ x) :=
sorry