
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_zext_slt_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (zeroExtend 32 x <ₛ 500#32) = ofBool (x <ᵤ 500#16) :=
sorry