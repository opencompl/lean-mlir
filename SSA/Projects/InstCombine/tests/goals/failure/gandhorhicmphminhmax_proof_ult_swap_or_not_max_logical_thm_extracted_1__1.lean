
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_swap_or_not_max_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ᵤ x_1) = 1#1 → 1#1 = ofBool (x != -1#8) :=
sorry