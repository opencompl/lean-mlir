
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_sext_sge_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 5),
  ofBool (signExtend 32 x ≤ₛ signExtend 32 x_1) = ofBool (x ≤ₛ signExtend 8 x_1) :=
sorry