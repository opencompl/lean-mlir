
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem different_size_sext_sext_sgt_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x <ₛ signExtend 25 x_1) = ofBool (signExtend 7 x <ₛ x_1) :=
sorry