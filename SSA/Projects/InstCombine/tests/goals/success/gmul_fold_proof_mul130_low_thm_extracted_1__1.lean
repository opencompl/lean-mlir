
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul130_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 130),
  ¬(65#130 ≥ ↑130 ∨ 65#130 ≥ ↑130 ∨ 65#130 ≥ ↑130) →
    (x_1 >>> 65#130 * (x &&& 36893488147419103231#130) + (x_1 &&& 36893488147419103231#130) * x >>> 65#130) <<< 65#130 +
        (x_1 &&& 36893488147419103231#130) * (x &&& 36893488147419103231#130) =
      x * x_1 :=
sorry