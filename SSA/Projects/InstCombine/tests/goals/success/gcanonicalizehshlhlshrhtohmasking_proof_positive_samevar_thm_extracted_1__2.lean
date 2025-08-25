
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) → ¬x ≥ ↑32 → x_1 <<< x >>> x = (-1#32) >>> x &&& x_1 :=
sorry