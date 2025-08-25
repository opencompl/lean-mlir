
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_zext_ule_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 9),
  ofBool (zeroExtend 32 x_1 ≤ᵤ zeroExtend 32 x) = ofBool (x_1 ≤ᵤ zeroExtend 9 x) :=
sorry