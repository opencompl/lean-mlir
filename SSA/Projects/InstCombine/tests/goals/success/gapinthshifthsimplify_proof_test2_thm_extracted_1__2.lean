
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 49),
  ¬(x_1 ≥ ↑49 ∨ x_1 ≥ ↑49) → ¬x_1 ≥ ↑49 → x_2.sshiftRight' x_1 ^^^ x.sshiftRight' x_1 = (x_2 ^^^ x).sshiftRight' x_1 :=
sorry