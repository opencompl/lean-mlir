
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t5_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬(x = 1#1 ∨ x_1 ≥ ↑32) → x = 1#1 → ¬1#32 <<< x_1 = 0 → False :=
sorry