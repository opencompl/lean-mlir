
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerLshr_lshrexact_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ True ∧ x <<< 5#32 >>> 10#32 <<< 10#32 ≠ x <<< 5#32 ∨ 10#32 ≥ ↑32) →
    ¬(True ∧ x >>> 5#32 <<< 5#32 ≠ x ∨ 5#32 ≥ ↑32) → x <<< 5#32 >>> 10#32 = x >>> 5#32 &&& 4194303#32 :=
sorry