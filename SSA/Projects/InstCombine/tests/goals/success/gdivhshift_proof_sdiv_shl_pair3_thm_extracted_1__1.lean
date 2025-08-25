
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_shl_pair3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨
        x_1 ≥ ↑32 ∨
          True ∧ (x_2 <<< x).sshiftRight' x ≠ x_2 ∨
            x ≥ ↑32 ∨ (x_2 <<< x == 0 || 32 != 1 && x_2 <<< x_1 == intMin 32 && x_2 <<< x == -1) = true) →
    True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨ x_1 ≥ ↑32 ∨ x ≥ ↑32 → False :=
sorry