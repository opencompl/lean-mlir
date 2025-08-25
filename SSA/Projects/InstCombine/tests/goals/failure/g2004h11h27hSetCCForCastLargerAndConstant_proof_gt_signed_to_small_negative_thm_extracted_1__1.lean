
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem gt_signed_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-17) <ₛ signExtend 32 x) = ofBool (BitVec.ofInt 8 (-17) <ₛ x) :=
sorry