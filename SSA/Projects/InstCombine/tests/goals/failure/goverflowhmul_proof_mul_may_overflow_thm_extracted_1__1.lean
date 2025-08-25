
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_may_overflow_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (zeroExtend 34 x_1 * zeroExtend 34 x ≤ᵤ 4294967295#34)) =
    zeroExtend 32 (ofBool (zeroExtend 34 x_1 * zeroExtend 34 x <ᵤ 4294967296#34)) :=
sorry