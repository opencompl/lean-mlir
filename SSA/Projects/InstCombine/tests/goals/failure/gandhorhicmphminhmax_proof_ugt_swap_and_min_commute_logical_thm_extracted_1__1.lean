
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_swap_and_min_commute_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 0#8) = 1#1 → ofBool (x <ᵤ x_1) = 0#1 :=
sorry