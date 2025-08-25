
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_nneg_uge_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬(True ∧ x.msb = true) → ofBool (zeroExtend 32 x ≤ᵤ signExtend 32 x_1) = ofBool (signExtend 16 x ≤ᵤ x_1) :=
sorry