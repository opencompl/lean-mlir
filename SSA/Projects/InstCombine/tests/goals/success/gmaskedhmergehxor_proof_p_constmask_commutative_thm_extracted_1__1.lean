
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_constmask_commutative_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& BitVec.ofInt 32 (-65281) &&& (x &&& 65280#32) != 0) = true → False :=
sorry