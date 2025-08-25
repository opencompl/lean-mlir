
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_slt_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) →
      ofBool (x_1 &&& (-1#8) <<< x <ₛ (-1#8) <<< x) = ofBool (x_1 <ₛ (-1#8) <<< x) :=
sorry