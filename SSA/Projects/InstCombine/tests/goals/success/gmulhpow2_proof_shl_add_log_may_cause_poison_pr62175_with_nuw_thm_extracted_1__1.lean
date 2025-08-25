
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ 4#8 <<< x >>> x ≠ 4#8 ∨ x ≥ ↑8) → x + 2#8 ≥ ↑8 → False :=
sorry