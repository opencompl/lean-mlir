
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_or_bitwise_or_icmps_comm1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_1 ≥ ↑8 → True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8 ∨ True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8 → False :=
sorry