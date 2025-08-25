
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_power2_and_icmp_shifted_mask_2147483648_805306368_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 1073741824#32) &&& ofBool (x &&& 805306368#32 != 805306368#32) = ofBool (x <ᵤ 805306368#32) :=
sorry