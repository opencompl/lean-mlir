
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_x_xor_neg_x_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  x_1 = 1#1 → ofBool ((x_2 ^^^ 123#8) &&& (x ^^^ 0#8 - x) == 0#8) = ofBool (x_2 ^^^ 123#8 ≤ᵤ x ^^^ x + -1#8) :=
sorry