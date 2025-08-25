
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem narrow_zext_mul_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  truncate 16 (zeroExtend 32 x_1 * x) = x_1 * truncate 16 x :=
sorry