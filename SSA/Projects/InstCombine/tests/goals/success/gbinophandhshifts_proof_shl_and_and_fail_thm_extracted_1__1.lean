
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_and_and_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(4#8 ≥ ↑8 ∨ 5#8 ≥ ↑8) → x_1 <<< 4#8 &&& (x <<< 5#8 &&& 88#8) = x_1 <<< 4#8 &&& (x <<< 5#8 &&& 64#8) :=
sorry