
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_sgt_to_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (123#8 <ₛ x) &&& ofBool (x &&& 2#8 == 0#8) = ofBool (x &&& BitVec.ofInt 8 (-2) == 124#8) :=
sorry