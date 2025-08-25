
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_eq_both_equal_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (127#8 >>> x == 127#8) = ofBool (x == 0#8) :=
sorry