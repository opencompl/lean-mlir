
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (4#8 <<< x).sshiftRight' x ≠ 4#8 ∨ x ≥ ↑8) → ¬x + 2#8 ≥ ↑8 → x_1 * 4#8 <<< x = x_1 <<< (x + 2#8) :=
sorry