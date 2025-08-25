
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem different_size_sext_sext_eq_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x_1 == signExtend 25 x) = ofBool (x_1 == signExtend 7 x) :=
sorry