
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_and_z_and_onefail_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 0#8) &&& ofBool (x != 1#8) &&& ofBool (x != 2#8) = ofBool (2#8 <ᵤ x) :=
sorry