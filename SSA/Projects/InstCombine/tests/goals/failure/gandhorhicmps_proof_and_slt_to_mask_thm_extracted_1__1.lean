
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_slt_to_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ₛ BitVec.ofInt 8 (-124)) &&& ofBool (x &&& 2#8 == 0#8) = ofBool (x <ₛ BitVec.ofInt 8 (-126)) :=
sorry