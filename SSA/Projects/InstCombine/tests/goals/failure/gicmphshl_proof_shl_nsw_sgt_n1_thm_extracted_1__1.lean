
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_sgt_n1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨ x ≥ ↑8) → ofBool (-1#8 <ₛ x_1 <<< x) = ofBool (-1#8 <ₛ x_1) :=
sorry