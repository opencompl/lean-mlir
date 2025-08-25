
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9a_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& BitVec.ofInt 32 (-2147483648) != 0#32) = ofBool (x <ₛ 0#32) :=
sorry