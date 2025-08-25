
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_const_slt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x ^^^ 123#8 <ₛ (x ^^^ 123#8) &&& 7#8) = ofBool (x <ₛ 0#8) :=
sorry