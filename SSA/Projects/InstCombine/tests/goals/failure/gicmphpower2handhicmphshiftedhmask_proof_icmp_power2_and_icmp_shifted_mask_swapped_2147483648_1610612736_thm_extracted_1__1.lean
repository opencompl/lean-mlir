
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1610612736#32 != 1610612736#32) &&& ofBool (x <ᵤ BitVec.ofInt 32 (-2147483648)) =
    ofBool (x <ᵤ 1610612736#32) :=
sorry