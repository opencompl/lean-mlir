
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_sgt10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 7#8).sshiftRight' 7#8 ≠ x ∨ 7#8 ≥ ↑8) →
    ofBool (BitVec.ofInt 8 (-127) <ₛ x <<< 7#8) = ofBool (-1#8 <ₛ x) :=
sorry