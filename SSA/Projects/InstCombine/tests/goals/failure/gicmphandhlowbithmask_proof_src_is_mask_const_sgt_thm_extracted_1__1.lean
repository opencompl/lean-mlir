
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_const_sgt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool ((x ^^^ 123#8) &&& 7#8 <ₛ x ^^^ 123#8) = ofBool (7#8 <ₛ x ^^^ 123#8) :=
sorry