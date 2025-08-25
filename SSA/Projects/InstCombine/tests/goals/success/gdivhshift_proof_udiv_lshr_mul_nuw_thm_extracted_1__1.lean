
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_lshr_mul_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ x_2.umulOverflow x_1 = true ∨ x ≥ ↑8 ∨ x_2 = 0) → x ≥ ↑8 → False :=
sorry