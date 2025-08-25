
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ule_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 8),
  ofBool (x_2 - x_1 ≤ᵤ signExtend 8 x) = ofBool (x_2 == x_1) ||| x :=
sorry