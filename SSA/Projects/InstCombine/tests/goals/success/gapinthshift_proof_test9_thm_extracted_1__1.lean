
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 17),
  ¬(16#17 ≥ ↑17 ∨ 16#17 ≥ ↑17) → x <<< 16#17 >>> 16#17 = x &&& 1#17 :=
sorry