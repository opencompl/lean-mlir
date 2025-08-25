
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_shift_amt_mismatch_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬(ofBool (0#32 ≤ₛ x_1) = 1#1 ∨ x ≥ ↑32) → ¬ofBool (x_1 <ₛ 0#32) = 1#1 → False :=
sorry