
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_sext_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 4),
  signExtend 16 x_1 &&& signExtend 16 x = signExtend 16 (x &&& signExtend 8 x_1) :=
sorry