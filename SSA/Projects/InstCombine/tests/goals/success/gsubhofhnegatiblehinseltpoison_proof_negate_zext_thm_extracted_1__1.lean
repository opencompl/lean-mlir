
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_zext_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x_1 - zeroExtend 8 x = x_1 + signExtend 8 x :=
sorry