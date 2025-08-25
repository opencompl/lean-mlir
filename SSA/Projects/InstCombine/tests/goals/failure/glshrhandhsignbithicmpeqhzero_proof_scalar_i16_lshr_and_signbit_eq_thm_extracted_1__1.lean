
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i16_lshr_and_signbit_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬x ≥ ↑16 → ofBool (x_1 >>> x &&& BitVec.ofInt 16 (-32768) == 0#16) = ofBool (-1#16 <ₛ x_1 >>> x) :=
sorry