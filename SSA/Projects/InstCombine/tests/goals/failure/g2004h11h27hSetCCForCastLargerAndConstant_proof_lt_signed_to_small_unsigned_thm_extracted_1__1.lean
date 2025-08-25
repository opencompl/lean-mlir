
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lt_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ᵤ 17#32) = ofBool (x <ᵤ 17#8) :=
sorry