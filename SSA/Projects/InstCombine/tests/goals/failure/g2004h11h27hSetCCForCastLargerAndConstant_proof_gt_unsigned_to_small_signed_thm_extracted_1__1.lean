
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem gt_unsigned_to_small_signed_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ₛ zeroExtend 32 x) = ofBool (17#8 <ᵤ x) :=
sorry