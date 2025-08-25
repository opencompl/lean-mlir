
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_no_commute_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → ¬(2#8 ≥ ↑8 ∨ 5#8 ≥ ↑8) → (x_1 - x <<< 3#8) <<< 2#8 = x_1 <<< 2#8 - x <<< 5#8 :=
sorry