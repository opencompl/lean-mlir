
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) → ¬x ≥ ↑8 → 16#8 <<< x + 7#8 <<< (x + 1#8) = 30#8 <<< x :=
sorry