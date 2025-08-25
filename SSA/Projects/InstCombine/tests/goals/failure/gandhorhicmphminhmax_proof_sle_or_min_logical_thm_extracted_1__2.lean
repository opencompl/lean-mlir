
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sle_or_min_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 ≤ₛ x) = 1#1 → ofBool (x_1 == BitVec.ofInt 8 (-128)) = ofBool (x_1 ≤ₛ x) :=
sorry