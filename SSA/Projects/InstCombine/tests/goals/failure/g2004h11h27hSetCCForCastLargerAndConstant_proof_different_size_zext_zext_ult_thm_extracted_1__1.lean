
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem different_size_zext_zext_ult_thm.extracted_1._1 : ∀ (x : BitVec 7) (x_1 : BitVec 4),
  ofBool (zeroExtend 25 x_1 <ᵤ zeroExtend 25 x) = ofBool (zeroExtend 7 x_1 <ᵤ x) :=
sorry