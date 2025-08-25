
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_sext_ne_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 != signExtend 32 x) = ofBool (x_1 != x) :=
sorry