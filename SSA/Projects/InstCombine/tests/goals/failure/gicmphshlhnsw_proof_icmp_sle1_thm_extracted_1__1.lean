
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_sle1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 1#8).sshiftRight' 1#8 ≠ x ∨ 1#8 ≥ ↑8) →
    ofBool (x <<< 1#8 ≤ₛ BitVec.ofInt 8 (-128)) = ofBool (x == BitVec.ofInt 8 (-64)) :=
sorry