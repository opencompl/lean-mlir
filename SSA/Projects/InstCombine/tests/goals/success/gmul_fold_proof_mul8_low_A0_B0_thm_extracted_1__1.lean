
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul8_low_A0_B0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) →
    (x_1 >>> 4#8 * x + x >>> 4#8 * x_1) <<< 4#8 + (x_1 &&& 15#8) * (x &&& 15#8) = x * x_1 :=
sorry