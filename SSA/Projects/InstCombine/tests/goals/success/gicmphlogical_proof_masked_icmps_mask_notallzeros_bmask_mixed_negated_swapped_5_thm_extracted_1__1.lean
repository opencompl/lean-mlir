
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 15#32 != 8#32) ||| ofBool (x &&& 15#32 == 0#32) = ofBool (x &&& 15#32 != 8#32) :=
sorry