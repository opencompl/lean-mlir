
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 3#32 == 0#32) = 1#1 → ofBool (x &&& 7#32 != 0#32) = 1#1 :=
sorry