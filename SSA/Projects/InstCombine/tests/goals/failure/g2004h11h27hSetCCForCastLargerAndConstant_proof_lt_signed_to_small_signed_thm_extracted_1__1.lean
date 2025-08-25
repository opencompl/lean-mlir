
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lt_signed_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ₛ 17#32) = ofBool (x <ₛ 17#8) :=
sorry