
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_sgt9_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 7#8).sshiftRight' 7#8 ≠ x ∨ 7#8 ≥ ↑8) →
    ofBool (BitVec.ofInt 8 (-128) <ₛ x <<< 7#8) = ofBool (x == 0#8) :=
sorry