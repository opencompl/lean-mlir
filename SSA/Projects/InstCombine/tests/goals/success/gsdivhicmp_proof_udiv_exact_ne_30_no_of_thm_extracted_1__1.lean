
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_exact_ne_30_no_of_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.umod (x &&& 7#8) ≠ 0 ∨ x &&& 7#8 = 0) → True ∧ (x &&& 7#8).umulOverflow 30#8 = true → False :=
sorry