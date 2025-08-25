
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test0_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 41),
  ¬(x_1 ≥ ↑41 ∨ x_1 ≥ ↑41) → ¬x_1 ≥ ↑41 → x_2 <<< x_1 &&& x <<< x_1 = (x_2 &&& x) <<< x_1 :=
sorry