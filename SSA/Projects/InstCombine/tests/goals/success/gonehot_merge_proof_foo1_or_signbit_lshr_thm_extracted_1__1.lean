
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_or_signbit_lshr_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_2 ≥ ↑32 ∨ x ≥ ↑32) →
    True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨
        x_2 ≥ ↑32 ∨
          True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨
            x ≥ ↑32 ∨
              True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨
                x_2 ≥ ↑32 ∨ True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨ x ≥ ↑32 →
      False :=
sorry