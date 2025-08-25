
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  True ∧ (x_1 &&& zeroExtend 8 x).msb = true → False :=
sorry