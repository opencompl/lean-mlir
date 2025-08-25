
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sel_equal_zext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → zeroExtend 32 (truncate 16 x) = x &&& 65535#32 :=
sorry