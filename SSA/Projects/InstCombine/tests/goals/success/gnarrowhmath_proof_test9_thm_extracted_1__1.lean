
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 → 16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow (BitVec.ofInt 32 (-32767)) = true → False :=
sorry