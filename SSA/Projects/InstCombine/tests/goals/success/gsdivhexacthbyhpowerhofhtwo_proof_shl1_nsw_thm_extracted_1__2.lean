
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl1_nsw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (1#8 <<< x).sshiftRight' x ≠ 1#8 ∨
        x ≥ ↑8 ∨
          True ∧ x_1.smod (1#8 <<< x) ≠ 0 ∨ (1#8 <<< x == 0 || 8 != 1 && x_1 == intMin 8 && 1#8 <<< x == -1) = true) →
    ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑8) → x_1.sdiv (1#8 <<< x) = x_1.sshiftRight' x :=
sorry