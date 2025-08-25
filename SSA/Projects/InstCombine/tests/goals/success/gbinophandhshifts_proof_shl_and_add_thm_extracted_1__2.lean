
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_and_add_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) → ¬1#8 ≥ ↑8 → x_1 <<< 1#8 + (x <<< 1#8 &&& 119#8) = (x_1 + (x &&& 59#8)) <<< 1#8 :=
sorry