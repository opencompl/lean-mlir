
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_eq_0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑32) → ofBool (x_1.sshiftRight' x == 0#32) = ofBool (x_1 == 0#32) :=
sorry