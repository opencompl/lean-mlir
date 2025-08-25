
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_both_cmp_operands_complex_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  ¬x_3 = 1#1 → ofBool (x ^^^ -1#32 ≤ₛ x_2 ^^^ -1#32) = ofBool (x_2 ≤ₛ x) :=
sorry