
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  x = 1#1 →
    ¬(4#64 ≥ ↑64 ∨
          3#64 ≥ ↑64 ∨
            True ∧ (x_1 >>> 4#64).saddOverflow (x_1 >>> 3#64) = true ∨
              True ∧ (x_1 >>> 4#64).uaddOverflow (x_1 >>> 3#64) = true) →
      ¬(16#64 = 0 ∨ 8#64 = 0) → x_1 / 16#64 + x_1 / 8#64 = x_1 >>> 4#64 + x_1 >>> 3#64 :=
sorry