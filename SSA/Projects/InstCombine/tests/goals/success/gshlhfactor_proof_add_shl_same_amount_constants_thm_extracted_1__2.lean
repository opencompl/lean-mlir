
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_shl_same_amount_constants_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) → ¬x ≥ ↑8 → 4#8 <<< x + 3#8 <<< x = 7#8 <<< x :=
sorry