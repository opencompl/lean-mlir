
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1073741823#32 != 1073741823#32) &&& ofBool (x <ᵤ 1073741824#32) = ofBool (x <ᵤ 1073741823#32) :=
sorry