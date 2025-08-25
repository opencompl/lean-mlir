
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul64_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬(32#64 ≥ ↑64 ∨ 32#64 ≥ ↑64 ∨ 32#64 ≥ ↑64) →
    (x_1 >>> 32#64 * (x &&& 4294967295#64) + (x_1 &&& 4294967295#64) * x >>> 32#64) <<< 32#64 +
        (x_1 &&& 4294967295#64) * (x &&& 4294967295#64) =
      x * x_1 :=
sorry