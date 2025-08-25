
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_lshr_comm_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ x ≥ ↑32) → x ≥ ↑32 → False :=
sorry