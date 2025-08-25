
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_shlnuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ x ≥ ↑32) → x_1 <<< x >>> x = x_1 :=
sorry