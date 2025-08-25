
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_signbit_lshr_and_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 → True ∧ BitVec.ofInt 8 (-128) >>> x_1 <<< x_1 ≠ BitVec.ofInt 8 (-128) ∨ x_1 ≥ ↑8 → False :=
sorry