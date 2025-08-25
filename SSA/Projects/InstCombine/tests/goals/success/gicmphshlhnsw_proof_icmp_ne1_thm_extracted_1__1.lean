
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 6#8).sshiftRight' 6#8 ≠ x ∨ 6#8 ≥ ↑8) →
    ofBool (x <<< 6#8 != BitVec.ofInt 8 (-128)) = ofBool (x != BitVec.ofInt 8 (-2)) :=
sorry