
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_and_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) → ¬4#8 ≥ ↑8 → x_1 <<< 4#8 &&& (x <<< 4#8 &&& 88#8) = (x &&& x_1) <<< 4#8 &&& 80#8 :=
sorry