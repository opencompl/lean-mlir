
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_masks_with_logical_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != 0#32) = 1#1 → ofBool (x_1 ||| x != 0#32) = 1#1 → 1#1 ||| ofBool (x != 0#32) = 1#1 :=
sorry