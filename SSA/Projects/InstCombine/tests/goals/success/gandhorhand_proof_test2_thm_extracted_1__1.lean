
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  (x_1 ||| zeroExtend 32 x) &&& 65536#32 = x_1 &&& 65536#32 :=
sorry