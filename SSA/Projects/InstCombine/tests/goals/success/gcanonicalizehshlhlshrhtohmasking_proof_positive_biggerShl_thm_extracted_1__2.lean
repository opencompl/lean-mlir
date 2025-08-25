
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerShl_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) → ¬5#32 ≥ ↑32 → x <<< 10#32 >>> 5#32 = x <<< 5#32 &&& 134217696#32 :=
sorry