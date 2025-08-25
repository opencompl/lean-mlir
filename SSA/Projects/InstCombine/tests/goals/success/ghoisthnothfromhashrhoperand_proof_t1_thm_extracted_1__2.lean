
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ^^^ -1#8) >>> x <<< x ≠ x_1 ^^^ -1#8 ∨ x ≥ ↑8) →
    ¬x ≥ ↑8 → (x_1 ^^^ -1#8).sshiftRight' x = x_1.sshiftRight' x ^^^ -1#8 :=
sorry