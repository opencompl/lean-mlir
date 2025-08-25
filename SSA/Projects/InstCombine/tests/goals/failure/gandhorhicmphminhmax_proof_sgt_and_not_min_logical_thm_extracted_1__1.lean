
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_and_not_min_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ₛ x_1) = 1#1 → ofBool (x_1 != BitVec.ofInt 8 (-128)) = ofBool (x <ₛ x_1) :=
sorry