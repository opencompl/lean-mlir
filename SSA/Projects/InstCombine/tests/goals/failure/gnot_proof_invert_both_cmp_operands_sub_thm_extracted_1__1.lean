
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem invert_both_cmp_operands_sub_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool ((x_1 ^^^ -1#32) - x <ᵤ 42#32) = ofBool (BitVec.ofInt 32 (-43) <ᵤ x_1 + x) :=
sorry