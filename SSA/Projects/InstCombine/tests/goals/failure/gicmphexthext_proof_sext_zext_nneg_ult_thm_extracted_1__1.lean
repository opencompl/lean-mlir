
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_nneg_ult_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x.msb = true) → ofBool (signExtend 32 x_1 <ᵤ zeroExtend 32 x) = ofBool (x_1 <ᵤ x) :=
sorry