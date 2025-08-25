
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨
        x ≥ ↑32 ∨ (x_1 == 0 || 32 != 1 && x_1 <<< x == intMin 32 && x_1 == -1) = true) →
    True ∧ (1#32 <<< x).sshiftRight' x ≠ 1#32 ∨ True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 → False :=
sorry