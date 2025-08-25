
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_mul_shl_nsw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.smulOverflow x_1 = true ∨
        True ∧ (x_2 <<< x).sshiftRight' x ≠ x_2 ∨
          x ≥ ↑5 ∨ (x_2 <<< x == 0 || 5 != 1 && x_2 * x_1 == intMin 5 && x_2 <<< x == -1) = true) →
    True ∧ 1#5 <<< x >>> x ≠ 1#5 ∨ x ≥ ↑5 ∨ (1#5 <<< x == 0 || 5 != 1 && x_1 == intMin 5 && 1#5 <<< x == -1) = true →
      False :=
sorry