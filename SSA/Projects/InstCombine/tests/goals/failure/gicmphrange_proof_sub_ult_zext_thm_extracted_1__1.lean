
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ult_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 8),
  ofBool (x_2 - x_1 <ᵤ zeroExtend 8 x) = ofBool (x_2 == x_1) &&& x :=
sorry