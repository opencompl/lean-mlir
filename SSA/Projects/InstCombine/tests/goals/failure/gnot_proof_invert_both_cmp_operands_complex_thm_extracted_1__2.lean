
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_both_cmp_operands_complex_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (x ^^^ -1#32 ≤ₛ x_1 ^^^ -1#32) = ofBool (x_1 ≤ₛ x) :=
sorry