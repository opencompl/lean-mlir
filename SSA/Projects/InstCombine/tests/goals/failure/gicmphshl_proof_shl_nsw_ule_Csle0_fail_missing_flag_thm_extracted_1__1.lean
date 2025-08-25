
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_ule_Csle0_fail_missing_flag_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨ x ≥ ↑8) →
    ofBool (x_1 <<< x ≤ᵤ BitVec.ofInt 8 (-19)) = ofBool (x_1 <<< x <ᵤ BitVec.ofInt 8 (-18)) :=
sorry