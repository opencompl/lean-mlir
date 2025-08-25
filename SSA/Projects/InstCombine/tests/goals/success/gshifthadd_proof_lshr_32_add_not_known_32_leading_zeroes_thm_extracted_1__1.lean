
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_32_add_not_known_32_leading_zeroes_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬32#64 ≥ ↑64 →
    True ∧ (x_1 &&& 8589934591#64).saddOverflow (x &&& 4294967295#64) = true ∨
        True ∧ (x_1 &&& 8589934591#64).uaddOverflow (x &&& 4294967295#64) = true ∨ 32#64 ≥ ↑64 →
      False :=
sorry