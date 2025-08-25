
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_mask_notpow2_ne_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x * 60#8 &&& 12#8 != 0#8) = ofBool (x * 12#8 &&& 12#8 != 0#8) :=
sorry