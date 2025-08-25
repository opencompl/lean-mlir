
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_nuw_uge_Csle0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨ True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑8) →
    ofBool (BitVec.ofInt 8 (-120) ≤ᵤ x_1 <<< x) = ofBool (BitVec.ofInt 8 (-121) <ᵤ x_1) :=
sorry