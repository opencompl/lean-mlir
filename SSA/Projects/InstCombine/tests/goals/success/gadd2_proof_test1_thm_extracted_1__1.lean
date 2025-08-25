
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 → zeroExtend 64 x_1 <<< 32#64 + x &&& 123#64 = x &&& 123#64 :=
sorry