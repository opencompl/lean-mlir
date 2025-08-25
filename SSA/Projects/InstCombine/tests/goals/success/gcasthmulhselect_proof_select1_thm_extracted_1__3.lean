
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select1_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → zeroExtend 32 (truncate 8 x_1 + truncate 8 x) = x_1 + x &&& 255#32 :=
sorry