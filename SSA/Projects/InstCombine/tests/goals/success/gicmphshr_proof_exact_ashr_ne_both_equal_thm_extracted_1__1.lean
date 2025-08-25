
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem exact_ashr_ne_both_equal_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ BitVec.ofInt 8 (-128) >>> x <<< x ≠ BitVec.ofInt 8 (-128) ∨ x ≥ ↑8) →
    ofBool ((BitVec.ofInt 8 (-128)).sshiftRight' x != BitVec.ofInt 8 (-128)) = ofBool (x != 0#8) :=
sorry