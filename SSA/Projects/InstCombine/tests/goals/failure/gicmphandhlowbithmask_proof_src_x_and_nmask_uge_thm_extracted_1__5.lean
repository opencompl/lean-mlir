
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_uge_thm.extracted_1._5 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  x_1 = 1#1 →
    ¬x ≥ ↑8 →
      ¬x_1 ^^^ 1#1 = 1#1 →
        ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) →
          ofBool ((-1#8) <<< x ≤ᵤ x_2 &&& (-1#8) <<< x) = ofBool ((-1#8) <<< x ≤ᵤ x_2) :=
sorry