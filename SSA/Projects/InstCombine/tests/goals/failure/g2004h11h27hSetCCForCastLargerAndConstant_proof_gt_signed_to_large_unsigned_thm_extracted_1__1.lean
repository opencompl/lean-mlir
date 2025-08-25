
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem gt_signed_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (1024#32 <ᵤ signExtend 32 x) = ofBool (x <ₛ 0#8) :=
sorry