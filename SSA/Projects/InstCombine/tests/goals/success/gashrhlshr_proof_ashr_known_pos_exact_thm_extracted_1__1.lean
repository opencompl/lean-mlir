
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_known_pos_exact_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& 127#8) >>> x <<< x ≠ x_1 &&& 127#8 ∨ x ≥ ↑8) →
    (x_1 &&& 127#8).sshiftRight' x = (x_1 &&& 127#8) >>> x :=
sorry