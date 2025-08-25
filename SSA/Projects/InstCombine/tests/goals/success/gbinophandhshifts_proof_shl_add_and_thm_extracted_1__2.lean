
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) → ¬1#8 ≥ ↑8 → x_1 <<< 1#8 &&& x <<< 1#8 + 123#8 = (x_1 &&& x + 61#8) <<< 1#8 :=
sorry