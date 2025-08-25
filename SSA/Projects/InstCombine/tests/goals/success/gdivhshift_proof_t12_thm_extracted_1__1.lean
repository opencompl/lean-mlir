
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t12_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x <<< 2#32 >>> 2#32 ≠ x ∨ 2#32 ≥ ↑32 ∨ x = 0) → x <<< 2#32 / x = 4#32 :=
sorry