
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exact_lshr_ne_noexactdiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ 80#8 >>> x <<< x ≠ 80#8 ∨ x ≥ ↑8) → ofBool (80#8 >>> x != 31#8) = 1#1 :=
sorry