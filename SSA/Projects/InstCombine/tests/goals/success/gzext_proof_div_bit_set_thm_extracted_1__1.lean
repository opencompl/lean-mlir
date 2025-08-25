
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem div_bit_set_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ (x == 0 || 32 != 1 && 1#32 <<< x_1 == intMin 32 && x == -1) = true) →
    True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨
        x_1 ≥ ↑32 ∨ (x == 0 || 32 != 1 && 1#32 <<< x_1 == intMin 32 && x == -1) = true →
      False :=
sorry