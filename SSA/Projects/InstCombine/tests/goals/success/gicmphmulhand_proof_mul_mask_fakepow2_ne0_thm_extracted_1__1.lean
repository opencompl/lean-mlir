
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_mask_fakepow2_ne0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x * 44#8 &&& 5#8 != 0#8) = ofBool (x &&& 1#8 != 0#8) :=
sorry