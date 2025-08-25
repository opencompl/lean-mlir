
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_shlnuw_ashrexact_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑8 ∨ True ∧ x_1.sshiftRight' x <<< x >>> x ≠ x_1.sshiftRight' x ∨ x ≥ ↑8) →
    x_1.sshiftRight' x <<< x = x_1 :=
sorry