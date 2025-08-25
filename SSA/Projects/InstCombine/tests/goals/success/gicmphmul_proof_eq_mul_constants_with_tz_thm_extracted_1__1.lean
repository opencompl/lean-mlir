
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_mul_constants_with_tz_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 * 12#32 != x * 12#32) = ofBool ((x_1 ^^^ x) &&& 1073741823#32 != 0#32) :=
sorry