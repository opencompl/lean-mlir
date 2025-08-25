
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_sext_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.msb = true) → ofBool (zeroExtend 32 x_1 == signExtend 32 x) = ofBool (x_1 == x) :=
sorry