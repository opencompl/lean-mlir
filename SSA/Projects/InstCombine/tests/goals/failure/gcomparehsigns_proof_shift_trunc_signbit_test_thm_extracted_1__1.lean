
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_trunc_signbit_test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 24#32) <ₛ 0#8) = ofBool (x <ₛ 0#32) :=
sorry