
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul8_low_miss_half_width_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ True ∧ (x_1 &&& 15#8).umulOverflow (x &&& 15#8) = true → False :=
sorry