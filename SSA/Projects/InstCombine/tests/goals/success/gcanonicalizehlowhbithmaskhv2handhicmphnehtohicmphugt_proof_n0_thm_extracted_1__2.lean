
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n0_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_2 ≥ ↑8 →
    ¬(True ∧ ((-1#8) <<< x_2).sshiftRight' x_2 ≠ -1#8 ∨ x_2 ≥ ↑8) →
      ofBool (((-1#8) <<< x_2 ^^^ -1#8) &&& x_1 != x) = ofBool (x_1 &&& ((-1#8) <<< x_2 ^^^ -1#8) != x) :=
sorry