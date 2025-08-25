
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_shifts1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    3#32 ≥ ↑32 ∨ 5#32 ≥ ↑32 ∨ True ∧ (x <<< 3#32 &&& 8#32 &&& (x <<< 5#32 &&& 32#32) != 0) = true → False :=
sorry