
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_icmps_bmask_notmixed_and_expected_false_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 3#32 != 15#32) &&& ofBool (x &&& 255#32 != 242#32) = ofBool (x &&& 255#32 != 242#32) :=
sorry