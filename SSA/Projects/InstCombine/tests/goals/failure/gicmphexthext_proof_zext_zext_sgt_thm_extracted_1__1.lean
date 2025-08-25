
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_zext_sgt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ zeroExtend 32 x_1) = ofBool (x <ᵤ x_1) :=
sorry