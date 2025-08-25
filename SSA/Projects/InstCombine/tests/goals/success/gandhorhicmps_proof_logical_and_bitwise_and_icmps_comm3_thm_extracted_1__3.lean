
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_and_bitwise_and_icmps_comm3_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_1 ≥ ↑8 → ¬ofBool (x_2 &&& 1#8 <<< x_1 != 0#8) = 1#1 → True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8 → False :=
sorry