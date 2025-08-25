
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_1_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  x_3 = 1#1 → ¬x ≥ ↑8 → (x_2 ^^^ -1#8).sshiftRight' x ^^^ -1#8 = x_2.sshiftRight' x :=
sorry