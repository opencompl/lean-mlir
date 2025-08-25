
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_pair3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑32 ∨ True ∧ (x_2 <<< x).sshiftRight' x ≠ x_2 ∨ True ∧ x_2 <<< x >>> x ≠ x_2 ∨ x ≥ ↑32 ∨ x_2 <<< x = 0) →
    True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨ x_1 ≥ ↑32 ∨ x ≥ ↑32 → False :=
sorry