
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_to_nxor_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& x &&& ((x_1 ||| x) ^^^ -1#32) != 0) = true → False :=
sorry