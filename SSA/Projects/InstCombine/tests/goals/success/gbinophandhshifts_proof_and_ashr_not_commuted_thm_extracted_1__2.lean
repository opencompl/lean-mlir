
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ashr_not_commuted_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    ¬x_1 ≥ ↑8 → (x_2.sshiftRight' x_1 ^^^ -1#8) &&& x.sshiftRight' x_1 = (x &&& (x_2 ^^^ -1#8)).sshiftRight' x_1 :=
sorry