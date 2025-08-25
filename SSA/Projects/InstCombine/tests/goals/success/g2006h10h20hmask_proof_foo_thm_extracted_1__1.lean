
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  zeroExtend 64 (truncate 32 x_1 &&& truncate 32 x) = x_1 &&& x &&& 4294967295#64 :=
sorry