
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_power2_and_icmp_shifted_mask_8_6_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 8#32) &&& ofBool (x &&& 6#32 != 6#32) = ofBool (x <ᵤ 6#32) :=
sorry