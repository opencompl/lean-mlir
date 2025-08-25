
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem low_mask_nsw_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32), 63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 :=
sorry