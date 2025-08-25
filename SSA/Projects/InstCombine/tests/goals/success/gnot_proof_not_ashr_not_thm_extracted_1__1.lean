
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_ashr_not_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → (x_1 ^^^ -1#32).sshiftRight' x ^^^ -1#32 = x_1.sshiftRight' x :=
sorry