
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_eq_thm.extracted_1._8 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    ¬x_2 ^^^ 1#1 = 1#1 →
      ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨ x_1 ≥ ↑8) →
        ofBool (0#8 == x &&& 0#8) = ofBool ((-1#8) <<< x_1 ≤ᵤ x) :=
sorry