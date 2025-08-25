
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 → 1#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 1#32).saddOverflow 1073741823#32 = true → False :=
sorry