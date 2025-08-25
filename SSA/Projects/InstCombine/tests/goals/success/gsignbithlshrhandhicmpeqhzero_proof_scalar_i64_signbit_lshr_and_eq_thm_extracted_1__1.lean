
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i64_signbit_lshr_and_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬x_1 ≥ ↑64 →
    True ∧ BitVec.ofInt 64 (-9223372036854775808) >>> x_1 <<< x_1 ≠ BitVec.ofInt 64 (-9223372036854775808) ∨ x_1 ≥ ↑64 →
      False :=
sorry