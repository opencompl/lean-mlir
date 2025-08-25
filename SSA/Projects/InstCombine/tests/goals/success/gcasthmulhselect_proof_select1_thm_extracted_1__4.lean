
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select1_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  x_3 = 1#1 → zeroExtend 32 (truncate 8 x_2) = x_2 &&& 255#32 :=
sorry