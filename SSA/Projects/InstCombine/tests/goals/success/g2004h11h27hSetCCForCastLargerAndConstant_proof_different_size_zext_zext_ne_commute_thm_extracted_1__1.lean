
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem different_size_zext_zext_ne_commute_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (zeroExtend 25 x_1 != zeroExtend 25 x) = ofBool (x_1 != zeroExtend 7 x) :=
sorry