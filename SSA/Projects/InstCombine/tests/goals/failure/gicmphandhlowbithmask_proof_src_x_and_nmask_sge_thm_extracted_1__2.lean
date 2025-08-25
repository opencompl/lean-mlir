
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_sge_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) →
      ofBool ((-1#8) <<< x ≤ₛ x_1 &&& (-1#8) <<< x) = ofBool ((-1#8) <<< x ≤ₛ x_1) :=
sorry