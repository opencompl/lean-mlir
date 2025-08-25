
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n13_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_2 ≥ ↑32 ∨ x ≥ ↑32) → True ∧ ((-1#32) <<< x_2).sshiftRight' x_2 ≠ -1#32 ∨ x_2 ≥ ↑32 ∨ x ≥ ↑32 → False :=
sorry