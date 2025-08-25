
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ True ∧ x <<< 5#8 >>> 5#8 <<< 5#8 ≠ x <<< 5#8 ∨ 5#8 ≥ ↑8) →
    ofBool (x <<< 5#8 >>> 5#8 == x) = ofBool (x <ᵤ 8#8) :=
sorry