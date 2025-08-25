
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ofBool (x <ᵤ zeroExtend 8 x_1) = ofBool (x == 0#8) &&& x_1 :=
sorry