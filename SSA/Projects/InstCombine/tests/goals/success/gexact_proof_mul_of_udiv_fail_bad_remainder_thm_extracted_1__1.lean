
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_udiv_fail_bad_remainder_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.umod 11#8 ≠ 0 ∨ 11#8 = 0) →
    True ∧ x.umod 11#8 ≠ 0 ∨ 11#8 = 0 ∨ True ∧ (x / 11#8).umulOverflow 6#8 = true → False :=
sorry