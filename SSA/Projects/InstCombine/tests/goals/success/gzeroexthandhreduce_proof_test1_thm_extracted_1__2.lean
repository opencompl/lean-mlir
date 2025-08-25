
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& 8#8).msb = true) → zeroExtend 32 x &&& 65544#32 = zeroExtend 32 (x &&& 8#8) :=
sorry