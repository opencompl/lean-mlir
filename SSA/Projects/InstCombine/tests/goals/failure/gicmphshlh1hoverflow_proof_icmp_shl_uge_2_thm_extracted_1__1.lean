
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_uge_2_thm.extracted_1._1 : ∀ (x : BitVec 5),
  ¬1#5 ≥ ↑5 → ofBool ((10#5 + x) <<< 1#5 ≤ᵤ 10#5 + x) = ofBool (x + 10#5 <ₛ 1#5) :=
sorry