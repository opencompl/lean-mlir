
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exact_lshr_ne_both_equal_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ 126#8 >>> x <<< x ≠ 126#8 ∨ x ≥ ↑8) → ofBool (126#8 >>> x != 126#8) = ofBool (x != 0#8) :=
sorry