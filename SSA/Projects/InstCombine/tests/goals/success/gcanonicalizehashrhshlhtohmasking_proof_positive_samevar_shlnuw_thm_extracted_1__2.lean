
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_shlnuw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ True ∧ x_1.sshiftRight' x <<< x >>> x ≠ x_1.sshiftRight' x ∨ x ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) → x_1.sshiftRight' x <<< x = (-1#8) <<< x &&& x_1 :=
sorry