
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t5_thm.extracted_1._8 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 32),
  ¬x_1 = 1#1 → ¬x_2 ≥ ↑32 → ¬1#32 <<< x_2 = 0 → x_2 / 1#32 <<< x_2 = x_2 >>> x_2 :=
sorry