
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_sext_sle_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (zeroExtend 32 x_1 ≤ₛ signExtend 32 x) = ofBool (signExtend 16 x_1 ≤ₛ x) :=
sorry