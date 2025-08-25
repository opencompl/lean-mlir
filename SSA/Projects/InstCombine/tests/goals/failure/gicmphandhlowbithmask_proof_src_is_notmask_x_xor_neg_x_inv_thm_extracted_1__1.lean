
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_x_xor_neg_x_inv_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ofBool (BitVec.ofInt 8 (-8) &&& (x ^^^ 123#8) == 0#8) = ofBool (x ^^^ 123#8 ≤ᵤ 7#8) :=
sorry