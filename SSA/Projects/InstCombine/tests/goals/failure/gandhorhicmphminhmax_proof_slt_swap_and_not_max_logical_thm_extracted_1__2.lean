
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_swap_and_not_max_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x <ₛ x_1) = 1#1 → 0#1 = ofBool (x <ₛ x_1) :=
sorry