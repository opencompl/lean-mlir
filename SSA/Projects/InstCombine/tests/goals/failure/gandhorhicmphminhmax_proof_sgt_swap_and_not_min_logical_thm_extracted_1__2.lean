
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_swap_and_not_min_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 <ₛ x) = 1#1 → 0#1 = ofBool (x_1 <ₛ x) :=
sorry