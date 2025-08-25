
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_mask_cmps_to_true_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x != 2147483647#32) ||| ofBool (x &&& 2147483647#32 != 0#32) = 1#1 :=
sorry