
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_fold_or_disjoint_cnt_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& 3#8 != 0) = true ∨ x ||| 3#8 ≥ ↑8) → ¬x ≥ ↑8 → 2#8 <<< (x ||| 3#8) = 16#8 <<< x :=
sorry