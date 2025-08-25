
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_mul_zext_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 * x &&& 255#32 = zeroExtend 32 (x_1 * truncate 8 x) :=
sorry