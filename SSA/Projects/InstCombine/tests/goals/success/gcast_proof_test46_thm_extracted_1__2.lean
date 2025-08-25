
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test46_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 →
    ¬(8#32 ≥ ↑32 ∨ True ∧ (truncate 32 x <<< 8#32 &&& 10752#32).msb = true) →
      zeroExtend 64 ((truncate 32 x &&& 42#32) <<< 8#32) = zeroExtend 64 (truncate 32 x <<< 8#32 &&& 10752#32) :=
sorry