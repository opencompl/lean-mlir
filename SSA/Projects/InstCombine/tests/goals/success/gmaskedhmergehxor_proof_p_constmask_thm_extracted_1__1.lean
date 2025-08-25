
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_constmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 65280#32 &&& (x &&& BitVec.ofInt 32 (-65281)) != 0) = true → False :=
sorry