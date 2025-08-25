
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sle_swap_or_not_min_commute_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 != BitVec.ofInt 8 (-128)) = 1#1 → ofBool (x_1 ≤ₛ x) = 1#1 :=
sorry