
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_inv2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ₛ 7#32) = 1#1 → ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑32) → x ≥ ↑32 → False :=
sorry