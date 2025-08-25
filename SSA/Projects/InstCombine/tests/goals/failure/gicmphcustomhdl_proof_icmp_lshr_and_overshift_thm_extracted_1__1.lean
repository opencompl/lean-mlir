
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_lshr_and_overshift_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → ofBool (x >>> 5#8 &&& 15#8 != 0#8) = ofBool (31#8 <ᵤ x) :=
sorry