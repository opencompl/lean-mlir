
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_lshr_comm_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ True ∧ (x_2 * x_2).uaddOverflow (x_1 <<< x) = true ∨ x ≥ ↑32) →
    x ≥ ↑32 ∨ True ∧ ((x_2 * x_2) >>> x).uaddOverflow x_1 = true → False :=
sorry