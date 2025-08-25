
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_ne_thm.extracted_1._3 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  x_1 = 1#1 →
    ¬x ≥ ↑8 →
      ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) →
        ofBool (x_2 &&& (-1#8) <<< x != (-1#8) <<< x) = ofBool (x_2 <ᵤ (-1#8) <<< x) :=
sorry