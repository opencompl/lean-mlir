
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_shlnuwnsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ True ∧ (x_1 >>> x <<< x).sshiftRight' x ≠ x_1 >>> x ∨ True ∧ x_1 >>> x <<< x >>> x ≠ x_1 >>> x ∨ x ≥ ↑8) →
    True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8 → False :=
sorry