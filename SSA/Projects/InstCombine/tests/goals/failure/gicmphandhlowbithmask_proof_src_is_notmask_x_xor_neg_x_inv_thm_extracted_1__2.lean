
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_x_xor_neg_x_inv_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 → ofBool ((x_1 ^^^ 0#8 - x_1) &&& (x ^^^ 123#8) == 0#8) = ofBool (x ^^^ 123#8 ≤ᵤ x_1 ^^^ x_1 + -1#8) :=
sorry