
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ ofBool (1#32 <<< x_1 &&& x != 0#32) = 1#1) →
    True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨ x_1 ≥ ↑32 ∨ ofBool (1#32 <<< x_1 &&& x != 0#32) = 1#1 → False :=
sorry