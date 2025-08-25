
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_sgt4_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 1#8).sshiftRight' 1#8 ≠ x ∨ 1#8 ≥ ↑8) →
    ofBool (BitVec.ofInt 8 (-2) <ₛ x <<< 1#8) = ofBool (-1#8 <ₛ x) :=
sorry