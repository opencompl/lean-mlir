
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lt_signed_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ₛ BitVec.ofInt 32 (-17)) = ofBool (x <ₛ BitVec.ofInt 8 (-17)) :=
sorry