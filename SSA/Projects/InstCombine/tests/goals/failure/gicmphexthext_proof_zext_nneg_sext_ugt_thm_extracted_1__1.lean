
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_sext_ugt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (signExtend 32 x <ᵤ zeroExtend 32 x_1) = ofBool (x <ᵤ x_1) :=
sorry