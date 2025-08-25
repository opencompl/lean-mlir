
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 32),
  ¬x_2 ≥ ↑32 → ¬ofBool (1#32 <<< x_2 &&& x_1 != 0#32) = 1#1 → True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨ x_2 ≥ ↑32 → False :=
sorry