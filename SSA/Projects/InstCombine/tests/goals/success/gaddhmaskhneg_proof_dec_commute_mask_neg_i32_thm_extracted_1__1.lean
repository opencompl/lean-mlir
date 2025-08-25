
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem dec_commute_mask_neg_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  -1#32 + (0#32 - x &&& x) = x + -1#32 &&& (x ^^^ -1#32) :=
sorry