
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_swap_and_max_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 ≤ₛ x) = 1#1 → 0#1 = ofBool (x == 127#8) :=
sorry