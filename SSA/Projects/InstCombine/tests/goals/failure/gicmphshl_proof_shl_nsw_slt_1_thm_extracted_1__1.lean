
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_slt_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨ x ≥ ↑8) → ofBool (x_1 <<< x <ₛ 1#8) = ofBool (x_1 <ₛ 1#8) :=
sorry