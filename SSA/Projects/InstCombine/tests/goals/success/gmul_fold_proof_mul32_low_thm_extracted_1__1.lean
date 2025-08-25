
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul32_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    (x_1 >>> 16#32 * (x &&& 65535#32) + (x_1 &&& 65535#32) * x >>> 16#32) <<< 16#32 +
        (x_1 &&& 65535#32) * (x &&& 65535#32) =
      x * x_1 :=
sorry