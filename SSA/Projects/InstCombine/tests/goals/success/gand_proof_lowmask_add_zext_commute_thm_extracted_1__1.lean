
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_add_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  x_1 * x_1 + zeroExtend 32 x &&& 65535#32 = zeroExtend 32 (x + truncate 16 (x_1 * x_1)) :=
sorry