
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_both_cmp_operands_add_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 <ₛ x_1 + (x ^^^ -1#32)) = ofBool (x - x_1 <ₛ -1#32) :=
sorry