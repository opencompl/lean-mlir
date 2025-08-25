
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_ugt_1_thm.extracted_1._1 : ∀ (x : BitVec 8), ¬1#8 ≥ ↑8 → ofBool (x <ᵤ x <<< 1#8) = ofBool (0#8 <ₛ x) :=
sorry