
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_const_sge_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x ^^^ 123#8 ≤ₛ (x ^^^ 123#8) &&& 31#8) = ofBool (x ^^^ 123#8 <ₛ 32#8) :=
sorry