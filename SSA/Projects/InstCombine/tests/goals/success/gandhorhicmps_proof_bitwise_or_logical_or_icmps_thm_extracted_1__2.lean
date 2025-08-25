
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_or_logical_or_icmps_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 == 42#8) = 1#1 →
    ¬x ≥ ↑8 → True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 → False :=
sorry