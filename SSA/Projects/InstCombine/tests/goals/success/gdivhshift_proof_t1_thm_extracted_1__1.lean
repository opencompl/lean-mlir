
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(x ≥ ↑32 ∨ (2#32 <<< x == 0 || 32 != 1 && zeroExtend 32 x_1 == intMin 32 && 2#32 <<< x == -1) = true) →
    x + 1#32 ≥ ↑32 → False :=
sorry