
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_masks_with_logical_or2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != -1#32) = 1#1 → ofBool (x_1 &&& x != -1#32) = 1#1 → 1#1 ||| ofBool (x != -1#32) = 1#1 :=
sorry