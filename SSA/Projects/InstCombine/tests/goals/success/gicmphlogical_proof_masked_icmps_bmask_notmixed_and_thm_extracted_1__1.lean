
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_icmps_bmask_notmixed_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 15#32 != 3#32) &&& ofBool (x &&& 255#32 != 243#32) = ofBool (x &&& 15#32 != 3#32) :=
sorry