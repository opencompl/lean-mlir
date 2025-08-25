
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_mask_pow2_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (0#8 <ₛ x * 44#8 &&& 4#8) = ofBool (x &&& 1#8 != 0#8) :=
sorry