
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (truncate 8 x_1 * truncate 8 x) = x_1 * x &&& 255#32 :=
sorry