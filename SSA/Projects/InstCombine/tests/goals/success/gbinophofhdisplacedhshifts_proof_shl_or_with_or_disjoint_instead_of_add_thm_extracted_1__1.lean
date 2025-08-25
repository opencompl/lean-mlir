
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_with_or_disjoint_instead_of_add_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ True ∧ (x &&& 1#8 != 0) = true ∨ x ||| 1#8 ≥ ↑8) → x ≥ ↑8 → False :=
sorry