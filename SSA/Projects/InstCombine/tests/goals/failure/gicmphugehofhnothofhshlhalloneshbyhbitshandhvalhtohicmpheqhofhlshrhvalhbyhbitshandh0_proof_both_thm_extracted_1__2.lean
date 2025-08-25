
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem both_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x_1).sshiftRight' x_1 ≠ -1#8 ∨
          x_1 ≥ ↑8 ∨ True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) →
      ofBool ((-1#8) <<< x ^^^ -1#8 ≤ᵤ (-1#8) <<< x_1 ^^^ -1#8) = ofBool ((-1#8) <<< x_1 ≤ᵤ (-1#8) <<< x) :=
sorry