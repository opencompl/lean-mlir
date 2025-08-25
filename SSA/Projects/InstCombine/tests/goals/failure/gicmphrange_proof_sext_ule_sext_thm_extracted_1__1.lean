
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_ule_sext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ofBool (signExtend 16 (x_1 * x_1) ≤ᵤ signExtend 16 x) = ofBool (x_1 * x_1 == 0#8) ||| x :=
sorry