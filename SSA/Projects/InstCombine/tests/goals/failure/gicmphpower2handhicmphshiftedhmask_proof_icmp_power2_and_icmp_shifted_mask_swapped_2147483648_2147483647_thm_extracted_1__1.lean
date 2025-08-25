
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2147483647#32 != 2147483647#32) &&& ofBool (x <ᵤ BitVec.ofInt 32 (-2147483648)) =
    ofBool (x <ᵤ 2147483647#32) :=
sorry