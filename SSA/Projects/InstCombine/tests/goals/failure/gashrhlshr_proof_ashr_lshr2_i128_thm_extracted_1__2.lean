
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr2_i128_thm.extracted_1._2 : ∀ (x x_1 : BitVec 128),
  ¬ofBool (5#128 <ₛ x_1) = 1#1 → ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑128) → x ≥ ↑128 → False :=
sorry