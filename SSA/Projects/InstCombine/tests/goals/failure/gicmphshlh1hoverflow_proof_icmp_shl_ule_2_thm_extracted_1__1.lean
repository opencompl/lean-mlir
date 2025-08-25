
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_ule_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (42#8 + x ≤ᵤ (42#8 + x) <<< 1#8) = ofBool (-1#8 <ₛ x + 42#8) :=
sorry