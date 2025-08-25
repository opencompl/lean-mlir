
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_shift_shift_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 2#32 ≥ ↑32) →
    (x &&& 7#32) <<< 3#32 ||| x <<< 2#32 &&& 28#32 = x <<< 3#32 &&& 56#32 ||| x <<< 2#32 &&& 28#32 :=
sorry