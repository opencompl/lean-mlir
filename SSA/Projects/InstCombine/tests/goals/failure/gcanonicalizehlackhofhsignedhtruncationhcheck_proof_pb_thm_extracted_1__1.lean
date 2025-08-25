
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pb_thm.extracted_1._1 : ∀ (x : BitVec 65),
  ¬(1#65 ≥ ↑65 ∨ True ∧ x <<< 1#65 >>> 1#65 <<< 1#65 ≠ x <<< 1#65 ∨ 1#65 ≥ ↑65) →
    ofBool (x == (x <<< 1#65).sshiftRight' 1#65) = ofBool (-1#65 <ₛ x + 9223372036854775808#65) :=
sorry