
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ True ∧ x <<< 5#8 >>> 5#8 <<< 5#8 ≠ x <<< 5#8 ∨ 5#8 ≥ ↑8) →
    ofBool ((x <<< 5#8).sshiftRight' 5#8 != x) = ofBool (x + BitVec.ofInt 8 (-4) <ᵤ BitVec.ofInt 8 (-8)) :=
sorry