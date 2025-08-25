
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_lshr_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑32 ∨
          True ∧ (x_2 <<< x_1).ssubOverflow x = true ∨
            True ∧ (x_2 <<< x_1).usubOverflow x = true ∨
              True ∧ (x_2 <<< x_1 - x) >>> x_1 <<< x_1 ≠ x_2 <<< x_1 - x ∨ x_1 ≥ ↑32) →
    True ∧ x >>> x_1 <<< x_1 ≠ x ∨
        x_1 ≥ ↑32 ∨ True ∧ x_2.ssubOverflow (x >>> x_1) = true ∨ True ∧ x_2.usubOverflow (x >>> x_1) = true →
      False :=
sorry