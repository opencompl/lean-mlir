
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_eq_1_thm.extracted_1._1 : ∀ (x : BitVec 8), ¬1#8 ≥ ↑8 → ofBool (x <<< 1#8 == x) = ofBool (x == 0#8) :=
sorry