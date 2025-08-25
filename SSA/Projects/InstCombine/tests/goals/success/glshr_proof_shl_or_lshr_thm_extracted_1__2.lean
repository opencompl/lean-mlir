
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_lshr_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑32 ∨ x_1 ≥ ↑32) →
    ¬x_1 ≥ ↑32 → (x_2 <<< x_1 ||| x) >>> x_1 = x >>> x_1 ||| x_2 :=
sorry