
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x ≥ ↑8 → (x_1 ^^^ 123#8).sshiftRight' x ^^^ -1#8 = (x_1 ^^^ BitVec.ofInt 8 (-124)).sshiftRight' x :=
sorry