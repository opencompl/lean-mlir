
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 → signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = 0#8 - x :=
sorry