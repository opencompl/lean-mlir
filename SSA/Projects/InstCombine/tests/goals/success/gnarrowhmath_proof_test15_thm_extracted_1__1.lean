
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 → 1#32 ≥ ↑32 ∨ True ∧ (8#32).ssubOverflow (x.sshiftRight' 1#32) = true → False :=
sorry