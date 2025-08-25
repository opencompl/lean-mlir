
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_signbit_shl_and_eq_X_is_constant1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (BitVec.ofInt 32 (-2147483648) <<< x &&& 12345#32 == 0#32) = 1#1 :=
sorry