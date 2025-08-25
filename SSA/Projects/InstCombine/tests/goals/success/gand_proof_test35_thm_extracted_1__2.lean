
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test35_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (0#32 - x &&& 240#32).msb = true) →
    0#64 - zeroExtend 64 x &&& 240#64 = zeroExtend 64 (0#32 - x &&& 240#32) :=
sorry