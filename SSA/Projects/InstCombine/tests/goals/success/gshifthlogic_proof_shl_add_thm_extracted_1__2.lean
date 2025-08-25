
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → ¬(5#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → (x_1 <<< 3#8 + x) <<< 2#8 = x_1 <<< 5#8 + x <<< 2#8 :=
sorry