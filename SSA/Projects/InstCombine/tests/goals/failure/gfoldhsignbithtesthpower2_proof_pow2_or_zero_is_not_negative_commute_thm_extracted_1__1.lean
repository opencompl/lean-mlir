
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pow2_or_zero_is_not_negative_commute_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (-1#8 <ₛ 0#8 - 42#8 * x &&& 42#8 * x) = ofBool (x * 42#8 != BitVec.ofInt 8 (-128)) :=
sorry