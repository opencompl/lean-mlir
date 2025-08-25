
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_eq_msb_low_last_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (127#8 >>> x == 0#8) = ofBool (6#8 <ᵤ x) :=
sorry