
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_zext_sle_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ofBool (zeroExtend 32 x_1 ≤ₛ zeroExtend 32 x) = ofBool (zeroExtend 16 x_1 ≤ᵤ x) :=
sorry