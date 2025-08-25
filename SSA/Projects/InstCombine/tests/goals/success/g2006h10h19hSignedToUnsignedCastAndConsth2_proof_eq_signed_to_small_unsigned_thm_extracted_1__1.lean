
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x == 17#32) = ofBool (x == 17#8) :=
sorry