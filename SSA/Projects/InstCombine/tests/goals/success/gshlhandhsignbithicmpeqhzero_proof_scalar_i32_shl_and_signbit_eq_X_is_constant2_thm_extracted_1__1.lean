
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_shl_and_signbit_eq_X_is_constant2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (1#32 <<< x &&& BitVec.ofInt 32 (-2147483648) == 0#32) = ofBool (x != 31#32) :=
sorry