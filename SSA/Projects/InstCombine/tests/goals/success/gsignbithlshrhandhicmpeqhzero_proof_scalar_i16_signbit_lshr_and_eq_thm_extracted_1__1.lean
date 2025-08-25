
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i16_signbit_lshr_and_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬x_1 ≥ ↑16 → True ∧ BitVec.ofInt 16 (-32768) >>> x_1 <<< x_1 ≠ BitVec.ofInt 16 (-32768) ∨ x_1 ≥ ↑16 → False :=
sorry