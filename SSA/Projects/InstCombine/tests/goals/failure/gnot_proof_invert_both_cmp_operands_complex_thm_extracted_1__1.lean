
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_both_cmp_operands_complex_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  x_2 = 1#1 → ofBool (x_1 + (x ^^^ -1#32) ≤ₛ x_1 ^^^ -1#32) = ofBool (x_1 ≤ₛ x - x_1) :=
sorry