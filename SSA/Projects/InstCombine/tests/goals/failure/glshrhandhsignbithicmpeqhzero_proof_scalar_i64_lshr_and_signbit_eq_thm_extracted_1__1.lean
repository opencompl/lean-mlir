
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i64_lshr_and_signbit_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬x ≥ ↑64 → ofBool (x_1 >>> x &&& BitVec.ofInt 64 (-9223372036854775808) == 0#64) = ofBool (-1#64 <ₛ x_1 >>> x) :=
sorry