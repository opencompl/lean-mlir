
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_masks_with_logical_or2_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 != -1#32) = 1#1 →
    ¬ofBool (x_2 &&& x != -1#32) = 1#1 → 1#1 ||| ofBool (x != -1#32) = ofBool (x_1 != 63#32) :=
sorry