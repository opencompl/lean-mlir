
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test37_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x * 7#32 &&& 240#32).msb = true) →
    zeroExtend 64 x * 7#64 &&& 240#64 = zeroExtend 64 (x * 7#32 &&& 240#32) :=
sorry