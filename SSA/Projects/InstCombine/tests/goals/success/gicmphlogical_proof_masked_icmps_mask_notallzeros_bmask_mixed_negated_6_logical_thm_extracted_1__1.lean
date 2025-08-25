
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 12#32 == 0#32) = 1#1 → 1#1 = ofBool (x &&& 15#32 != 8#32) :=
sorry