
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul128_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 128),
  ¬(64#128 ≥ ↑128 ∨ 64#128 ≥ ↑128 ∨ 64#128 ≥ ↑128) →
    (x_1 >>> 64#128 * (x &&& 18446744073709551615#128) + (x_1 &&& 18446744073709551615#128) * x >>> 64#128) <<< 64#128 +
        (x_1 &&& 18446744073709551615#128) * (x &&& 18446744073709551615#128) =
      x * x_1 :=
sorry