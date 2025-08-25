
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_signbit_shl_and_eq_nonzero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → ofBool (BitVec.ofInt 32 (-2147483648) <<< x_1 &&& x == 1#32) = 0#1 :=
sorry