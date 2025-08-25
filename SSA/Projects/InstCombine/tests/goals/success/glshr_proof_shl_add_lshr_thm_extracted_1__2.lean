
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_lshr_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑32 ∨ True ∧ (x_2 <<< x_1).uaddOverflow x = true ∨ x_1 ≥ ↑32) →
    ¬(x_1 ≥ ↑32 ∨ True ∧ (x >>> x_1).uaddOverflow x_2 = true) → (x_2 <<< x_1 + x) >>> x_1 = x >>> x_1 + x_2 :=
sorry