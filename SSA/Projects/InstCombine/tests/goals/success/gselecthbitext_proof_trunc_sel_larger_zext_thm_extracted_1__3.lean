
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sel_larger_zext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ¬(True ∧ (x &&& 65535#32).msb = true) → zeroExtend 64 (truncate 16 x) = zeroExtend 64 (x &&& 65535#32) :=
sorry