
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (73#32).ssubOverflow (x &&& 31#32) = true ∨ True ∧ (73#32).usubOverflow (x &&& 31#32) = true → False :=
sorry