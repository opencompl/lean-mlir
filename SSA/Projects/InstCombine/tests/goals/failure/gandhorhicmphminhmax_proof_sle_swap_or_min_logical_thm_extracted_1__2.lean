
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sle_swap_or_min_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x ≤ₛ x_1) = 1#1 → ofBool (x == BitVec.ofInt 8 (-128)) = ofBool (x ≤ₛ x_1) :=
sorry