
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lt_signed_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ᵤ 1024#32) = ofBool (-1#8 <ₛ x) :=
sorry