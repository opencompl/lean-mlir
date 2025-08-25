
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_sameconst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) → x <<< 5#32 >>> 5#32 = x &&& 134217727#32 :=
sorry