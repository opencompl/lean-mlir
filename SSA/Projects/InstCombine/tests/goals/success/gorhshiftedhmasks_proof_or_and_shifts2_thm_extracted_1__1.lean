
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_shifts2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    3#32 ≥ ↑32 ∨ 4#32 ≥ ↑32 ∨ True ∧ (x <<< 3#32 &&& 896#32 &&& (x >>> 4#32 &&& 7#32) != 0) = true → False :=
sorry