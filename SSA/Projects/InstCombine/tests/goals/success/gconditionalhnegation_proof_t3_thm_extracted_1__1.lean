
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 2),
  signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = x + signExtend 8 x_1 ^^^ signExtend 8 x_1 :=
sorry