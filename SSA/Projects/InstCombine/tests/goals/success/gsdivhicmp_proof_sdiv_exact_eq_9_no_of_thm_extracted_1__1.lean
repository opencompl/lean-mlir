
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_exact_eq_9_no_of_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smod (x &&& 7#8) ≠ 0 ∨ (x &&& 7#8 == 0 || 8 != 1 && x_1 == intMin 8 && x &&& 7#8 == -1) = true) →
    True ∧ (x &&& 7#8).smulOverflow 9#8 = true ∨ True ∧ (x &&& 7#8).umulOverflow 9#8 = true → False :=
sorry