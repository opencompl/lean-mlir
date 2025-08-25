
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14a_thm.extracted_1._1 : ∀ (x : BitVec 79),
  ¬(4#79 ≥ ↑79 ∨ 4#79 ≥ ↑79) → (x <<< 4#79 &&& 1234#79) >>> 4#79 = x &&& 77#79 :=
sorry