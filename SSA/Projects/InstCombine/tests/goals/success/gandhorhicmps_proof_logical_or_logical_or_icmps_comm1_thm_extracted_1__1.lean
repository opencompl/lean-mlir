
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_or_logical_or_icmps_comm1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 → ofBool (x_1 &&& 1#8 <<< x == 0#8) = 1#1 → True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 → False :=
sorry