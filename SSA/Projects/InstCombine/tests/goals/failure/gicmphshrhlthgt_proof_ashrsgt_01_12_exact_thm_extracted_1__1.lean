
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_01_12_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 1#4 <<< 1#4 ≠ x ∨ 1#4 ≥ ↑4) →
    ofBool (BitVec.ofInt 4 (-4) <ₛ x.sshiftRight' 1#4) = ofBool (x != BitVec.ofInt 4 (-8)) :=
sorry