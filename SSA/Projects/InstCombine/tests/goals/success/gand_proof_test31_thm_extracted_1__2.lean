
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test31_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬4#32 ≥ ↑32 → ¬x = 1#1 → zeroExtend 32 x <<< 4#32 &&& 16#32 = 0#32 :=
sorry