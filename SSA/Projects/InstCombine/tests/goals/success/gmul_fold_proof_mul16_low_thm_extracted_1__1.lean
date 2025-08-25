
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul16_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16) →
    (x_1 >>> 8#16 * (x &&& 255#16) + (x_1 &&& 255#16) * x >>> 8#16) <<< 8#16 + (x_1 &&& 255#16) * (x &&& 255#16) =
      x * x_1 :=
sorry